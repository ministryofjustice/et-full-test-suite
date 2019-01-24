module EtFullSystem
  module Test
    module Et1ClaimHelper
      def start_a_new_et1_claim
        load_et1_start_page
        et1_apply_page.start_a_claim
      end

      def load_et1_start_page(in_language: ::EtFullSystem::Test::Messaging.instance.current_locale)
        et1_apply_page.load
        case in_language
        when :cy then et1_apply_page.switch_to_welsh
        when :en then nil
        else raise "We only support languages en and cy - #{in_language} is not supported"
        end
      end

      def et1_answer_login
        et1_application_number_page.set(@claimant)
        et1_application_number_page.save_and_continue
      end

      def et1_answer_claimant_questions
        et1_claimant_details_page.set(@claimant)
        et1_claimant_details_page.save_and_continue
      end

      def et1_answer_group_claimants_questions
        et1_group_claimants_page.set(@claimant)
        group_claims_csv = @claimant[0].dig(:group_claims_csv)
        if group_claims_csv
          et1_group_claimants_upload_page.set(@claimant)
          et1_group_claimants_upload_page.save_and_continue
        else
          et1_group_claimants_page.save_and_continue
        end
      end

      def et1_answer_representatives_questions
        et1_representatives_details_page.set(@representative)
        et1_representatives_details_page.save_and_continue
      end

      def et1_answer_respondents_questions
        et1_respondents_details_page.set(@respondent)
        et1_respondents_details_page.save_and_continue
        et1_additional_respondents_details_page.set(@respondent)
        et1_additional_respondents_details_page.save_and_continue
      end

      def et1_answer_employment_details_questions
        et1_employment_details_page.set(@employment)
        et1_employment_details_page.save_and_continue
      end

      def et1_answer_claim_type_questions
        et1_claim_type_page.set(@claim)
        et1_claim_type_page.save_and_continue
      end

      def et1_answer_claim_details_questions
        et1_claim_details_page.set(@claim)
        et1_claim_details_page.save_and_continue
      end

      def et1_answer_claim_outcome_questions
        et1_claim_outcome_page.set(@claim)
        et1_claim_outcome_page.save_and_continue
      end

      def et1_answer_more_about_the_claim_questions
        et1_more_about_the_claim_page.set(@claim)
        et1_more_about_the_claim_page.save_and_continue
      end

      def et1_submit_claim
        et1_submission_page.submit_claim
      end

      def et1_submit_your_feedback
        et1_your_feedback_page.main_content.comments.set('feedback page has no validation')
        et1_your_feedback_page.main_content.suggestions.set("Don't understand why user is allowed to submit blank page")
        et1_your_feedback_page.main_content.email_address.set('no validating here either')
        et1_your_feedback_page.send_your_feedback
      end
    end
  end
end

