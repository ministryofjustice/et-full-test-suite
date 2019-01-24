require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class RepresentativeSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(representative:)
            return has_no_representative? if representative.nil?
            expected_values = {
              name: representative[:name] || '',
              organisation_name: representative[:organisation_name] || '',
              address: a_hash_including(
                building: representative[:building],
                street: representative[:street],
                locality: representative[:locality],
                county: representative[:county],
                post_code: representative[:post_code].tr(' ', '')
              ),
              dx_number: representative[:dx_number] || '',
              phone_number: representative[:telephone_number] || '',
              mobile_number: representative[:representative_mobile] || '',
              reference: representative[:representative_reference] || '',
              contact_preference: representative[:representative_contact_preference].to_s.split('.')[-2],
              fax_number: representative[:representative_fax] || ''
            }
            # @TODO Re add the code below once the email address is being filled in
            #               email_address: representative[:email_address] || '',
            expect(mapped_field_values).to include(expected_values)
          end

          private

          def empty_address_attributes
            {
              building: '',
              street: '',
              locality: '',
              county: '',
              post_code: ''
            }
          end

          def has_no_representative?
            expected_values = {
              name: '',
              organisation_name: '',
              address: a_hash_including(
                building: '',
                street: '',
                locality: '',
                county: '',
                post_code: ''
              ),
              dx_number: '',
              phone_number: '',
              mobile_number: '',
              reference: '',
              contact_preference: nil,
              email_address: '',
              fax_number: ''
            }
            expect(mapped_field_values).to include(expected_values)
          end
        end
      end
    end
  end
end
