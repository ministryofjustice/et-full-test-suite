require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class YourDetailsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claimant:)
            expected_values = {
                title: title_for(claimant.title),
                first_name: claimant.first_name,
                last_name: claimant.last_name,
                dob_day: claimant.date_of_birth.split('/')[0],
                dob_month: claimant.date_of_birth.split('/')[1],
                dob_year: claimant.date_of_birth.split('/')[2],
                gender: gender_for(claimant.gender),
                building: claimant.building,
                street: claimant.street,
                locality: claimant.locality,
                county: claimant.county,
                post_code: post_code_for(claimant.post_code),
                telephone_number: claimant.telephone_number,
                alternative_telephone_number: claimant.alternative_telephone_number,
                email_address: claimant.email_address,
                correspondence: contact_preference_for(claimant.correspondence)
            }
            expect(mapped_field_values).to include expected_values
          end

        end
      end
    end
  end
end
