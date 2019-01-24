require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class HeaderSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(respondent:)
            # @TODO Review this conditional after march 2019 - once the pdf has been sorted, it should have the date_received and rtf fields
            if locale == :cy
              expected_values = {
                case_number: respondent.case_number
              }
              expect(mapped_field_values).to eql(expected_values)
            else
              expected_values = {
                case_number: respondent.case_number,
                date_received: date_for(Time.now),
                rtf: respondent.rtf_file.present?
              }
              expect(mapped_field_values).to eql(expected_values).or(include(expected_values.merge(date_received: date_for(1.hour.ago))))
            end
          end
        end
      end
    end
  end
end
