require_relative './base_section'
require_relative './additional_respondent_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class AdditionalRespondentsSection < BaseSection
          section :additional_respondents, :et1_review_question_labelled, 'review.additional_respondents.questions.additional_respondents.label' do
            element :answer, :css, 'td'
          end
          sections :respondents, AdditionalRespondentSection, :et1_review_additional_claimant_labelled, 'review.additional_respondents.respondent_header'

          def has_correct_translation?(respondents:)
            additional_respondents_data = respondents.drop(1)
            if additional_respondents_data.length == 0
              aggregate_failures 'validating for no extra respondents' do
                expect(self).to have_additional_respondents
                expect(self).to have_no_respondents
                expect(additional_respondents).to have_answer(text: t('review.additional_respondents.questions.additional_respondents.options.no'))
              end
            else
              aggregate_failures 'validating for multiple respondents' do
                expect(self).to have_no_additional_respondents
                expect(self).to have_respondents
                expect(self).to have_all_additional_respondents_for(respondents.drop(1))
              end
            end
            true
          end

          def has_all_additional_respondents_for?(additional_respondents)
            idx = 0
            additional_respondents.all? do |respondent|
              respondents[idx].has_correct_translation?(respondent)
              idx += 1
            end
          end
        end
      end
    end
  end
end
