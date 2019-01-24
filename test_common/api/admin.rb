require 'rspec/matchers'
module EtFullSystem
  module Test
    class AdminApi
      include ::RSpec::Matchers
      include ::EtFullSystem::Test::I18n
      def url
        Configuration.admin_url
      end

      def get_token
        response = request(:get, url)
        self.csrf_token = response.body.match(/csrf-token" content="([^"]*)"/)[1]
      end

      def login
        get_token
        request(:post, "#{url}/login",
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          },
          cookies: cookies_hash,
          body: {
            admin_user: {
              username: ::EtFullSystem::Test::Configuration.admin_username,
              password: ::EtFullSystem::Test::Configuration.admin_password,
              remember_me: '0'
            },
            authenticity_token: csrf_token
          })
      end

      def respondents_api
        login
        claimants = request(:get, "#{url}/respondents.json", cookies: cookies_hash)
        JSON.parse(claimants.body).map(&:with_indifferent_access)
      end

      def claimants_api
        login
        claimants = request(:get, "#{url}/claimants.json", cookies: cookies_hash)
        JSON.parse(claimants.body).map(&:with_indifferent_access)
      end

      def acas_certificate_logs_api
        login
        acas_logs = request(:get, "#{url}/download_logs.json", cookies: cookies_hash)
        JSON.parse(acas_logs.body).map(&:with_indifferent_access)
      end

      def admin_diversity_data
        login
        response = request(:get, "#{url}/diversity_responses.json?
          claim_type_contains=data[:claim_type]
          &sex_contains=data[:sex_contains] 
          &sexual_identity_contains=data[:sexual_identity]
          &age_group_contains=data[:age_group]
          &ethnicity_contains=data[:ethnicity]
          &ethnicity_subgroup_contains=data[:ethnicity_subgroup]
          &disability_contains=data[:disability]
          &caring_responsibility_contains=data[:caring_responsibility]
          &gender_contains=data[:gender]
          &gender_at_birth_contains=data[:gender_at_birth]
          &pregnancy_contains=data[:pregnancy]
          &relationship_contains=data[:relationship]
          &religion_contains=data[:religion]", cookies: cookies_hash)
        data = response[0].delete_if { |k, v| %w"id created_at updated_at".include? k}
        return data.inject({}) do |a, (k,v)|
          if v.nil? 
            a[k] = nil
          elsif v == "Jehovah's Witnesses"
            a[k] = v
          else
            a[k] = t("#{k}.#{v}")
          end
          a
        end
      end

      private

      def request(method, *args)
        self.last_response = HTTParty.send(method, *args)
        self.cookies_hash = HTTParty::CookieHash.new
        cookies_hash.add_cookies(last_response.headers['set-cookie'])
        last_response
      end
      
      attr_accessor :cookies_hash, :last_response, :csrf_token
    end
  end
end
