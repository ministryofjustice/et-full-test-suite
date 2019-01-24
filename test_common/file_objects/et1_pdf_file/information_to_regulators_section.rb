require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class InformationToRegulatorsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            expected_values = {
                whistle_blowing: yes_no_for(claim.whistleblowing_claim, yes: 'yes', no: 'no'),
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
