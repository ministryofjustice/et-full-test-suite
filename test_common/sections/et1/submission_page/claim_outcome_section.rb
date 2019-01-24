require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class ClaimOutcomeSection < BaseSection
          section :what_outcome, :et1_review_question_labelled, 'review.claim_outcome.questions.what_outcome' do
            include RSpec::Matchers
            include ::EtFullSystem::Test::I18n

            element :answer, :css, 'td'

            def has_answer_for?(value)
              if value.nil? || value.empty?
                expect(self).to have_answer(text: t('review.common.not_entered'))
              else
                outcomes = Array(value)
                aggregate_failures 'validating outcomes' do
                  outcomes.each do |outcome|
                    key = "simple_form.options.claim.desired_outcomes.#{outcome.to_s.split('.').last}"
                    expect(answer).to have_text(t(key), exact: false)
                  end
                end
              end
              true
            end
          end
          section :outcome_details, :et1_review_question_labelled, 'review.claim_outcome.questions.outcome_details' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(claim:)
            aggregate_failures 'validating claim outcome section' do
              expect(what_outcome).to have_answer_for(claim.preferred_outcome)
              expect(outcome_details).to have_answer(text: with_not_entered(claim.preferred_outcome_notes))
            end
            true
          end
        end
      end
    end
  end
end
