require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class ClaimTypeSection < BaseSection
          section :send_to_whistleblowing_body, :et1_review_question_labelled, 'review.claim_type.questions.send_to_whistleblowing_body' do
            element :answer, :css, 'td'
          end
          section :whistleblowing, :et1_review_question_labelled, 'review.claim_type.questions.whistleblowing' do
            element :answer, :css, 'td'
          end
          section :types, :et1_review_question_labelled, 'review.claim_type.questions.types.title' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :css, 'td'

            def has_answer_for?(claim)
              if claim.claim_types.nil? || claim.claim_types.empty?
                raise "claim types must always exist - the application should not let you get this far"
              else
                # Other type of claim is never shown as a claim type
                claim_types = claim.claim_types.reject {|c| c.to_s.split('.').last == 'is_other_type_of_claim'}
                aggregate_failures 'validating claim types' do
                  claim_types.each do |type|
                    key = type.to_s.gsub(/.*\.options\.claim_type\./, 'review.claim_type.questions.types.options.')
                    expect(answer).to have_text(t(key), exact: false)
                  end
                end
              end
              true
            end
          end

          def has_correct_translation?(claim:)
            aggregate_failures 'validating claim type section' do
              expect(send_to_whistleblowing_body).to have_answer(text: with_not_entered(convert_yes_no(claim.send_to_relevant_person)))
              expect(whistleblowing).to have_answer(text: with_not_entered(convert_yes_no(claim.whistleblowing_claim)))
              expect(types).to have_answer_for(claim)
            end
            true
          end
        end
      end
    end
  end
end
