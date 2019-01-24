require 'rspec/matchers'
require 'pdf-forms'
module EtFullSystem
  module Test
    module FileObjects
      # A base class for all pdf files
      class BasePdfFile < Base # rubocop:disable Metrics/ClassLength
        include EtFullSystem::Test::I18n
        include ::RSpec::Matchers

        private

        def field_values
          @field_values ||= form.fields.inject({}) do |acc, field|
            if field.type == "Button" && field.options.present?
              acc[field.name] = field.options.include?(field.value) ? unescape(field.value) : nil
            else
              acc[field.name] = unescape(field.value)
            end
            acc
          end
        end

        def form
          @form ||= PdfForms.new('pdftk', utf8_fields: true).read(tempfile.path)
        end

        def unescape(val)
          return val if val.nil?
          CGI.unescape_html(val)
        end
      end
    end
  end
end
