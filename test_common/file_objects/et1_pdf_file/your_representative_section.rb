require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class YourRepresentativeSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(representative:)
            expected_values = {
                name_of_organisation: representative.organisation_name,
                name_of_representative: representative.name,
                building: representative.building,
                street: representative.street,
                locality: representative.locality,
                county: representative.county,
                post_code: post_code_for(representative.post_code),
                dx_number: representative.dx_number,
                telephone_number: representative.telephone_number,
                alternative_telephone_number: representative.alternative_telephone_number,
                reference: nil, # Should be populated by ET1 but it isnt yet
                email_address: representative.email_address,
                communication_preference: 'Off', # ET1 Doesnt capture this
                fax_number: nil # ET1 Doesnt capture this
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
