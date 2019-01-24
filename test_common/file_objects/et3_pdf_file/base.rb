require 'rspec/matchers'
require 'pdf-forms'
require_relative '../base_pdf_file'
module EtFullSystem
  module Test
    module FileObjects
      # Represents the ET3 PDF file and provides assistance in validating its contents
      module Et3PdfFileSection
        class Base < ::EtFullSystem::Test::FileObjects::BasePdfFile
          UndefinedField = Object.new

          def initialize(*args, locale:)
            super(*args)
            self.locale = locale
          end

          private

          attr_accessor :locale

          def i18n_section
            self.class.name.demodulize.underscore.gsub(/_section\z/, '')
          end

          def true_false_for(val, yes: true,  no: false)
            return nil if val.nil?
            val ? yes : no
          end

          def mapped_field_values
            return @mapped_field_values if defined?(@mapped_field_values)
            lookup = t("response_pdf_fields.#{i18n_section}", locale: locale)
            @mapped_field_values = lookup.inject({}) do |acc, (key, value)|
              v = mapped_value(value, key: key)
              acc[key.to_sym] = v unless v === UndefinedField
              acc
            end
          end

          def mapped_value(value,  key:)
            if value.is_a?(Hash) && !value.key?(:field_name)
              value.inject({}) do |acc, (inner_key, inner_value)|
                v = mapped_value(inner_value, key: inner_key)
                acc[inner_key] = v unless v === UndefinedField
                acc
              end
            elsif value.is_a?(Hash) && value[:field_name] === false
              UndefinedField
            else
              field_value_for(value, key: key)
            end
          end

          def field_value_for(value, key:)
            if value.key?(:select_values)
              raw = raw_value_from_pdf(value)
              ret = value[:select_values].detect { |(key, v)|  v == raw }.try(:[], 0)
              return true if ret == :true || ret === true
              return false if ret == :false || ret === false
              return ret.to_s if ret
              return nil if raw == value[:unselected_value]
              raise "Invalid value - '#{raw}' is not in the selected_values list or the unselected_value for field '#{key}' for section #{self.class.name}"
            else
              field_values[value[:field_name]]
            end
          end

          def raw_value_from_pdf(value)
            value[:field_name].is_a?(Array) ? value[:field_name].map { |f| field_values[f] } : field_values[value[:field_name]]
          end


          def date_for(date)
            return date.strftime('%d/%m/%Y') if date.is_a?(Date) || date.is_a?(Time) || date.is_a?(DateTime)
            Time.zone.parse(date).strftime('%d/%m/%Y')
          end

          def decimal_for(number)
            number.to_s
          end

          def encode_value_for_pdftk(value)
            value.gsub(/â/, '&#226;')
          end

          def tri_state(value)
            return nil if value.nil?
            value == 'Yes'
          end
        end
      end
    end
  end
end
