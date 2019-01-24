require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class ClaimantSection < BaseSection
          section :date_of_birth, :et1_review_question_labelled, 'review.claimant.questions.date_of_birth' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :css, 'td'

            def has_answer_for?(claimant)
              if claimant.date_of_birth.nil?
                expect(self).to have_answer(text: t('review.common.not_entered'))
              else
                date = Date.parse(claimant.date_of_birth)
                expect(self).to have_answer(text: date.strftime("%d #{t("date.month_names")[date.month]} %Y"))
              end
              true
            end
          end
          section :preferred_contact, :et1_review_question_labelled, 'review.claimant.questions.preferred_contact' do
            element :answer, :css, 'td'
          end
          section :address, :et1_review_question_labelled, 'review.claimant.questions.address' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :css, 'td'

            def has_answer_for?(claimant)
              if claimant.building.nil? && claimant.street.nil? && claimant.locality.nil? && claimant.county.nil? && claimant.post_code.nil?
                expect(self).to have_answer(text: t('review.common.not_entered'))
              else
                expect(self).to have_answer(text: "#{claimant.building}#{claimant.street}#{claimant.locality}#{claimant.county}#{claimant.post_code}")
              end
              true
            end
          end
          section :email, :et1_review_question_labelled, 'review.claimant.questions.email' do
            element :answer, :css, 'td'
          end
          section :assistance_required, :et1_review_question_labelled, 'review.claimant.questions.assistance_required' do
            element :answer, :css, 'td'
          end
          section :full_name, :et1_review_question_labelled, 'review.claimant.questions.full_name' do
            element :answer, :css, 'td'
          end
          section :mobile, :et1_review_question_labelled, 'review.claimant.questions.mobile' do
            element :answer, :css, 'td'
          end
          section :phone, :et1_review_question_labelled, 'review.claimant.questions.phone' do
            element :answer, :css, 'td'
          end
          section :gender, :et1_review_question_labelled, 'review.claimant.questions.gender' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(claimant:)
            aggregate_failures 'validating claimant section' do
              expect(date_of_birth).to have_answer_for(claimant)
              expect(preferred_contact).to have_answer(text: with_not_entered(factory_translate claimant.correspondence))
              expect(address).to have_answer_for(claimant)
              expect(email).to have_answer(text: with_not_entered(claimant.email_address))
              expect(assistance_required).to have_answer(text: with_not_entered(factory_translate claimant.has_special_needs))
              expect(full_name).to have_answer(text: "#{factory_translate(claimant.title)} #{claimant.first_name} #{claimant.last_name}")
              expect(mobile).to have_answer(text: with_not_entered(claimant.alternative_telephone_number))
              expect(phone).to have_answer(text: with_not_entered(claimant.telephone_number))
              expect(gender).to have_answer(text: with_not_entered(factory_translate claimant.gender))
            end
            true
          end
        end
      end
    end
  end
end
