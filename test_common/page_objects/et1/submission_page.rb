module EtFullSystem
  module Test
    module Et1
      class SubmissionPage < BasePage
        include RSpec::Matchers
        #Check your claim
        section :main_header, '.main-header' do
          element :page_header, :main_header, 'claim_reviews.show.header', exact: false
        end
        section :main_content, '#content .main-section .main-content' do
          section :group_claim_section, SubmissionPageSections::GroupClaimSection, :et1_review_section_labelled, 'review.group_claim.title'
          section :additional_respondents_section, SubmissionPageSections::AdditionalRespondentsSection, :et1_review_section_labelled, 'review.additional_respondents.title'
          section :additional_information_section, SubmissionPageSections::AdditionalInformationSection, :et1_review_section_labelled, 'review.additional_information.title'
          section :claim_details_section, SubmissionPageSections::ClaimDetailsSection,:et1_review_section_labelled, 'review.claim_details.title'
          section :claim_outcome_section, SubmissionPageSections::ClaimOutcomeSection,  :et1_review_section_labelled, 'review.claim_outcome.title'
          section :claim_type_section, SubmissionPageSections::ClaimTypeSection, :et1_review_section_labelled, 'review.claim_type.title'
          section :claimant_section, SubmissionPageSections::ClaimantSection,:et1_review_section_labelled, 'review.claimant.title'
          section :employment_section, SubmissionPageSections::EmploymentSection ,:et1_review_section_labelled, 'review.employment.title'
          section :representative_section, SubmissionPageSections::RepresentativeSection,:et1_review_section_labelled, 'review.representative.title'
          section :respondent_section, SubmissionPageSections::RespondentSection,:et1_review_section_labelled, 'review.respondent.title'

          element :submit_claim_button, :input_with_value, 'review.submit_claim'
        end

        def submit_claim
          main_content.submit_claim_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?(claimants:, respondents:, claim:, employment:, representative:)
          expect(main_content.group_claim_section).to have_correct_translation(claimants: claimants)
          expect(main_content.additional_respondents_section).to have_correct_translation(respondents: respondents)
          expect(main_content.additional_information_section).to have_correct_translation(claim: claim)
          expect(main_content.claim_details_section).to have_correct_translation(claim: claim)
          expect(main_content.claim_outcome_section).to have_correct_translation(claim: claim)
          expect(main_content.claim_type_section).to have_correct_translation(claim: claim)
          expect(main_content.claimant_section).to have_correct_translation(claimant: claimants.first)
          expect(main_content.employment_section).to have_correct_translation(employment: employment)
          expect(main_content.representative_section).to have_correct_translation(representative: representative)
          expect(main_content.respondent_section).to have_correct_translation(respondent: respondents.first)
          expect(main_content).to have_submit_claim_button
          true
        end
      end
    end
  end
end
