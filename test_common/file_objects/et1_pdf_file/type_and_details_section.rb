require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class TypeAndDetailsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          # Note that at present, the test framework suggests only one claim type but ET1 can have many selected - this code will need to expect
          # various fields to be Yes/No based on a list of claim types in the future.
          # Also, alot of values have hard coded true or falses as I expect these to come from factories but at the time of writing this there are
          # no values for them - so Im not going mad - calling a method that returns "yes" or "no" - knowing it will always return "no" as I am passing it false
          # it simply to allow for the value to be added at some point soon.
          def has_contents_for?(claim:)
            claim_types = claim_types_for(claim.claim_types)
            expected_values = {
                unfairly_dismissed: yes_no_for(claim_types.include?(:is_unfair_dismissal), yes: 'yes', no: 'Off'),
                discriminated_age: yes_no_for(claim_types.include?(:discrimination_age), yes: 'yes', no: 'Off'),
                discriminated_race: yes_no_for(claim_types.include?(:discrimination_race), yes: 'yes', no: 'Off'),
                discriminated_gender_reassignment: yes_no_for(claim_types.include?(:discrimination_gender_reassignment), yes: 'yes', no: 'Off'),
                discriminated_disability: yes_no_for(claim_types.include?(:discrimination_disability), yes: 'yes', no: 'Off'),
                discriminated_pregnancy: yes_no_for(claim_types.include?(:discrimination_pregnancy_or_maternity), yes: 'yes', no: 'Off'),
                discriminated_marriage: yes_no_for(claim_types.include?(:discrimination_marriage_or_civil_partnership), yes: 'yes', no: 'Off'),
                discriminated_sexual_orientation: yes_no_for(claim_types.include?(:discrimination_sexual_orientation), yes: 'yes', no: 'Off'),
                discriminated_sex: yes_no_for(claim_types.include?(:discrimination_sex_including_equal_pay), yes: 'yes', no: 'Off'),
                discriminated_religion: yes_no_for(claim_types.include?(:discrimination_religion_or_belief), yes: 'yes', no: 'Off'),
                claiming_redundancy_payment: yes_no_for(claim_types.include?(:pay_redundancy), yes: 'yes', no: 'Off'),
                owed_notice_pay: yes_no_for(claim_types.include?(:pay_notice), yes: 'yes', no: 'Off'),
                owed_holiday_pay: yes_no_for(claim_types.include?(:pay_holiday), yes: 'yes', no: 'Off'),
                owed_arrears_of_pay: yes_no_for(claim_types.include?(:pay_arrears), yes: 'yes', no: 'Off'),
                owed_other_payments: yes_no_for(claim_types.include?(:pay_other), yes: 'yes', no: 'Off'),
                other_type_of_claim: yes_no_for(claim_types.include?(:is_other_type_of_claim), yes: 'yes', no: 'Off'),
                other_type_of_claim_details: claim.other_claimant_names,
                claim_description: claim.description
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
