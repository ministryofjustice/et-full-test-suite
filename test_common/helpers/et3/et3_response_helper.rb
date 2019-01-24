module EtFullSystem
  module Test
    module Et3ResponseHelper
      def start_a_new_et3_response
        load_et3_start_page
        start_page.next
      end

      def load_et3_start_page(in_language: ::EtFullSystem::Test::Messaging.instance.current_locale)
        start_page.load
        case in_language
        when :cy then start_page.switch_to_welsh
        when :en then nil
        else raise "We only support languages en and cy - #{in_language} is not supported"
        end
        start_page.assert_language(in_language)
      end

      def et3_answer_respondents_details
        user = @respondent[0]
        respondents_details_page.case_number_question.set(user.case_number)
        respondents_details_page.name_question.set(user.name)
        respondents_details_page.contact_question.set(user.contact)
        respondents_details_page.building_name_question.set(user.building_name)
        respondents_details_page.street_question.set(user.street_name)
        respondents_details_page.town_question.set(user.town)
        respondents_details_page.county_question.set(user.county)
        respondents_details_page.postcode_question.set(user.postcode)
        respondents_details_page.dx_number_question.set(user.dx_number)
        respondents_details_page.contact_number_question.set(user.contact_number)
        respondents_details_page.contact_mobile_number_question.set(user.contact_mobile_number)
        respondents_details_page.contact_preference_question.set_for(user)
        respondents_details_page.organisation_more_than_one_site_question.set_for(user)
        respondents_details_page.organisation_employ_gb_question.set(user.organisation_employ_gb)

        respondents_details_page.next
      end

      def et3_answer_required_espondents_details
        user = @respondent[0]
        respondents_details_page.case_number_question.set(user.case_number)
        respondents_details_page.name_question.set(user.name)
        respondents_details_page.building_name_question.set(user.building_name)
        respondents_details_page.street_question.set(user.street_name)
        respondents_details_page.town_question.set(user.town)
        respondents_details_page.postcode_question.set(user.postcode)
        respondents_details_page.organisation_more_than_one_site_question.set_for(user)

        respondents_details_page.next
      end

      def et3_answer_claimants_details
        user = @claimant[0]
        claimants_details_page.claimants_name_question.set(user.claimants_name)
        claimants_details_page.agree_with_early_conciliation_details_question.set_for(user)
        claimants_details_page.agree_with_employment_dates_question.set_for(user)
        claimants_details_page.continued_employment_question.set_for(user.continued_employment)
        claimants_details_page.agree_with_claimants_description_of_job_or_title_question.set_for(user)

        claimants_details_page.next
      end

      def et3_answer_required_claimants_details
        user = @claimant[0]
        claimants_details_page.agree_with_employment_dates_question.set_for(user)

        claimants_details_page.next
      end

      def et3_answer_earnings_and_benefits
        user = @claimant[0]
        earnings_and_benefits_page.agree_with_claimants_hours_question.set_for(user)
        earnings_and_benefits_page.agree_with_earnings_details_question.set_for(user)
        earnings_and_benefits_page.agree_with_claimant_notice_question.set_for(user)
        earnings_and_benefits_page.agree_with_claimant_pension_benefits_question.set_for(user)

        earnings_and_benefits_page.next
      end

      def et3_answer_defend_claim_question
        user = @claimant[0]
        response_page.defend_claim_question.set_for(user)

        response_page.next
      end

      def et3_answer_representative
        user = @representative[0]
        if t(user.have_representative) == t('questions.have_representative.yes.label')
          your_representative_page.have_representative_question.set_for(user)
          your_representative_page.next
          your_representatives_details_page.type_of_representative_question.set_for(user)
          your_representatives_details_page.representative_org_name_question.set(user.organisation_name)
          your_representatives_details_page.representative_name_question.set(user.name)
          your_representatives_details_page.representative_building_question.set(user.building)
          your_representatives_details_page.representative_street_question.set(user.street)
          your_representatives_details_page.representative_town_question.set(user.locality)
          your_representatives_details_page.representative_county_question.set(user.county)
          your_representatives_details_page.representative_postcode_question.set(user.post_code)
          your_representatives_details_page.representative_phone_question.set(user.telephone_number)
          your_representatives_details_page.representative_mobile_question.set(user.representative_mobile)
          your_representatives_details_page.representative_dx_number_question.set(user.dx_number)
          your_representatives_details_page.representative_reference_question.set(user.representative_reference)
          your_representatives_details_page.representative_contact_preference_question.set_for(user)
          your_representatives_details_page.next
        else
          your_representative_page.next
        end
      end

      def et3_answer_disability_question
        user = @respondent[0]
        disability_page.disability_question.set_for(user)

        disability_page.next
      end

      def et3_employers_contract_claim
        user = @respondent[0]
        employers_contract_claim_page.make_employer_contract_claim_question.set_for(user)

        employers_contract_claim_page.next
      end

      def et3_answer_no_to_employers_contract_claim
        employers_contract_claim_page.make_employer_contract_claim_question.no.selector.click

        employers_contract_claim_page.next
      end

      def et3_displays_edited_answer
        make_employer_contract_claim_row.make_employer_contract_claim_answer.text
      end

      def additional_information
        user = @respondent[0]
        if user[:rtf_file]
          additional_information_page.attach_additional_information_file(user)
        end
        additional_information_page.next
      end

      def et3_confirmation_of_supplied_details
        user = @respondent[0]
        confirmation_of_supplied_details_page.email_receipt_question.set(user.email_receipt)
        confirmation_of_supplied_details_page.next
      end

      def et3_edit_answer
        confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers.edit_answers_link.click
      end

      def et3_displays_edited_answer
        confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers.make_employer_contract_claim_row.make_employer_contract_claim_answer.text
      end
    end
  end
end
