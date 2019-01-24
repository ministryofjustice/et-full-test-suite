require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class AdditionalInformationSection < BaseSection
          section :important_details, :et1_review_question_labelled, 'review.additional_information.questions.important_details' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(claim:)
            expect(important_details).to have_answer(text: with_not_entered(claim.other_important_details))
          end
        end
      end
    end
  end
end
