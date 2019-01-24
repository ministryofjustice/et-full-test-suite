require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class AdditionalInformationSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            expected_values = {
                additional_information: claim.other_important_details
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
