require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class ClaimDetailsSection < BaseSection
          section :claim_details, :et1_review_question_labelled, 'review.claim_details.questions.claim_details' do
            element :answer, :css, 'td'
          end
          section :other_known_claimants, :et1_review_question_labelled, 'review.claim_details.questions.other_known_claimants' do
            element :answer, :css, 'td'
          end
          section :attached_documents, :et1_review_question_labelled, 'review.claim_details.questions.attached_documents.title' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(claim:)
            aggregate_failures 'validating claim details section' do
              expect(claim_details).to have_answer(text: with_not_entered(claim.description))
              expect(other_known_claimants).to have_answer(text: with_not_entered(claim.other_claimant_names))
              expect(attached_documents).to have_answer(text: with_not_entered(claim.rtf_file))
            end
            true
          end
        end
      end
    end
  end
end
