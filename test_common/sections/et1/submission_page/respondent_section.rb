require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class RespondentSection < BaseSection
          section :name, :et1_review_question_labelled, 'review.respondent.questions.name' do
            element :answer, :css, 'td'
          end
          section :address, :et1_review_question_labelled, 'review.respondent.questions.address' do
            element :answer, :css, 'td'
          end
          section :phone, :et1_review_question_labelled, 'review.respondent.questions.phone' do
            element :answer, :css, 'td'
          end
          section :acas_number, :et1_review_question_labelled, 'review.respondent.questions.acas_number' do
            element :answer, :css, 'td'
          end
          section :work_address, :et1_review_question_labelled, 'review.respondent.questions.work_address' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(respondent:)
            aggregate_failures 'validating respondent' do
              expect(name).to have_answer(text: with_not_entered(respondent.name))
              expect(acas_number).to have_answer(text: with_not_entered(respondent.acas_number))
              expect(address).to have_answer(text: with_not_entered_address(respondent))
              expect(phone).to have_answer(text: with_not_entered(respondent.telephone_number))
              expect(work_address).to have_answer(text: with_not_entered_work_address(respondent))
            end
            true
          end

          private

          def with_not_entered_address(obj)
            if obj.nil? || (obj.building.nil? && obj.street.nil? && obj.locality.nil? && obj.county.nil? && obj.post_code.nil?)
              t('review.common.not_entered')
            else
              "#{obj.building}#{obj.street}#{obj.locality}#{obj.county}#{obj.post_code}"
            end
          end

          def with_not_entered_work_address(obj)
            if obj.nil? || (obj.work_building.nil? && obj.work_street.nil? && obj.work_locality.nil? && obj.work_county.nil? && obj.work_post_code.nil?)
              t('review.common.not_entered')
            else
              "#{obj.work_building}#{obj.work_street}#{obj.work_locality}#{obj.work_county}#{obj.work_post_code}"
            end
          end
        end
      end
    end
  end
end
