require 'zip'
require 'httparty'
require 'active_support'
require 'active_support/core_ext'

module EtFullSystem
  module Test
    # This is a singleton class where the instance provides assistance with keeping track of the current state
    # of the atos interface.
    # When the admin can move to rails 5.2 - we can use activestorage in it and then we can potentially do some
    # stuff so that a user can search for a filename WITHIN a zip file - in which case, this interface could use
    # that instead of the ATOS API.
    #
    # If we end up moving to scaling up the test processes, this may well link into a central redis server that
    # keeps track of the zip files across all processes (so we can tidy them up even when one file within a zip
    # belongs to a claim created in process 1 and another in process 2)
    class AtosInterface

      def delete_zip_files
        api.list_zip_filenames.each { |filename| api.delete_zip_file(filename) }
      end

      def has_zip_file_containing?(identifier, **args)
        find_file_in_any_zip(identifier, **args)
      end

      def download_from_any_zip(identifier, **args)
        filename = find_file_in_any_zip(identifier, **args)
        raise "No zip file containing #{identifier} - #{args} was found" unless filename.present?
        Dir.mktmpdir do |dir|
          all_filenames_in_all_zip_files.extract(filename, to: dir)
          File.read(File.join(dir, filename))
        end
      end

      def download_from_any_zip_to_tempfile(identifier, **args)
        tempfile = Tempfile.new
        filename = find_file_in_any_zip(identifier, **args)
        raise "No zip file containing #{identifier} - #{args} was found" unless filename.present?
        all_filenames_in_all_zip_files.extract(filename, to: File.dirname(tempfile.path), as: File.basename(tempfile.path))
        tempfile.rewind
        tempfile
      end

      def initialize(username:, password:)
        self.api = AtosInterfaceApi.new base_url: Configuration.atos_api_url,
                                        username: username,
                                        password: password
      end

      private

      def find_file_in_any_zip(identifier, **args)
        all_filenames_in_all_zip_files.find do |filename|
          filename_matches?(filename, identifier, **args)
        end
      end

      def filename_matches?(filename, identifier, **args)
        user = args[:user]
        if user.dig(:first_name).present?
          first_name = user.dig(:first_name).gsub(/\s/, '_').gsub(/\W/, '').parameterize(separator: '_', preserve_case: true).tr(' ', '_')
          last_name = user.dig(:last_name).gsub(/\s/, '_').gsub(/\W/, '').parameterize(separator: '_', preserve_case: true)
        else
          company_name_underscored = user.dig(:name).gsub(/\s/, '_').gsub(/\W/, '').parameterize(separator: '_', preserve_case: true)
        end
        case identifier
        when :et1_claim_pdf_for
          filename.end_with?("ET1_#{first_name}_#{last_name}.pdf")
        when :et1_claim_xml_for
          filename.end_with?("ET1_#{first_name}_#{last_name}.xml")
        when :et1_claim_txt_for
          filename.end_with?("ET1_#{first_name}_#{last_name}.txt")
        when :et1_filename_start_with
          filename.start_with?(args[:local_office])
        when :et1_claim_csv_for
          filename.end_with?("ET1a_#{first_name}_#{last_name}.csv")
        when :et1_claim_rtf_for
          filename.end_with?("ET1_Attachment_#{first_name}_#{last_name}.rtf")
        when :et1a_claim_txt_for
          filename.end_with?("ET1a_#{first_name}_#{last_name}.txt")
        when :et3_response_txt_for
          reference = args[:reference]
          filename == "#{reference}_ET3_#{company_name_underscored}.txt"
        when :et3_response_pdf_for
          reference = args[:reference]
          filename == "#{reference}_ET3_#{company_name_underscored}.pdf"
        when :et3_filename_start_with
          filename.start_with?(args[:local_postcode])
        when :et3_response_rtf_for
          reference = args[:reference]
          filename == "#{reference}_ET3_Attachment_#{company_name_underscored}.rtf"
        end
      end

      def all_filenames_in_all_zip_files
        AtosInterfaceZipFilenameRepo.new(cache: filename_cache, api: api)
      end

      def filename_cache
        @filename_cache ||= {}
      end

      attr_accessor :api
    end

    class AtosInterfaceZipFilenameRepo
      include Enumerable

      def initialize(cache:, api:)
        self.filename_cache = cache
        self.api = api
        self.filenames = []
      end

      def each
        fetch unless fetched?
        filenames.each do |zip_filename|
          files_in_filename(zip_filename).each do |filename|
            yield filename
          end
        end
      end

      def extract(filename, to:, as: filename)
        fetch unless fetched?
        zip_filename = zip_filename_for(filename)
        raise "No zip file contains #{filename}" unless zip_filename.present?
        tmp_file = Tempfile.new
        tmp_file.binmode
        api.download(zip_filename, to: tmp_file)
        tmp_file.rewind
        ::Zip::File.open(tmp_file.path) do |z|
          z.extract(filename, File.join(to, as)) { true }
        end
      end


      def files_in_filename(zip_filename)
        return filename_cache[zip_filename] if filename_cache.key?(zip_filename)
        tmp_file = Tempfile.new
        tmp_file.binmode

        api.download(zip_filename, to: tmp_file)
        tmp_file.rewind
        ::Zip::File.open(tmp_file.path).glob('**/*').map(&:name).tap do |files|
          filename_cache[zip_filename] = files
        end
      ensure
        if tmp_file
          tmp_file.close
          tmp_file.unlink
        end
      end

      def zip_filename_for(filename)
        (key, _value) = filename_cache.find { |(_key, value)| value.include?(filename) }
        return key
      end

      def fetch
        self.filenames = api.list_zip_filenames
        @fetched = true
      end

      def fetched?
        @fetched
      end

      attr_accessor :filename_cache, :filenames, :api
    end

    class AtosInterfaceApi
      def initialize(base_url:, username:, password:)
        self.base_url = base_url
        self.username = username
        self.password = password
      end

      def list_zip_filenames
        response = HTTParty.get("#{base_url}/list", basic_auth: { username: username, password: password })
        response.body.lines.map(&:strip)
      end

      def download(zip_filename, to:)
        puts "ATOS API - Downloading #{zip_filename}"
        HTTParty.get("#{base_url}/download/#{zip_filename}", basic_auth: { username: username, password: password }) do |chunk|
          to.write(chunk)
        end
      end

      def delete_zip_file(filename)
        response = HTTParty.post("#{base_url}/delete", 
          basic_auth: { username: username, password: password }, 
          body: {
            filename: filename
        })
      end

      private

      attr_accessor :base_url, :username, :password
    end
  end
end
