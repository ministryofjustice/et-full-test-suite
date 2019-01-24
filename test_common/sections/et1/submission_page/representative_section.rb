require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class RepresentativeSection < BaseSection
          section :type_of_representative, :et1_review_question_labelled, 'review.representative.questions.type_of_representative' do
            element :answer, :css, 'td'
          end
          section :email, :et1_review_question_labelled, 'review.representative.questions.email' do
            element :answer, :css, 'td'
          end
          section :address, :et1_review_question_labelled, 'review.representative.questions.address' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :css, 'td'

            def has_answer_for?(rep)
              if rep.building.nil? && rep.street.nil? && rep.locality.nil? && rep.county.nil? && rep.post_code.nil?
                expect(self).to have_answer(text: t('review.common.not_entered'))
              else
                expect(self).to have_answer(text: "#{rep.building}#{rep.street}#{rep.locality}#{rep.county}#{rep.post_code}")
              end
              true
            end
          end
          section :full_name, :et1_review_question_labelled, 'review.representative.questions.full_name' do
            element :answer, :css, 'td'
          end
          section :dx_number, :et1_review_question_labelled, 'review.representative.questions.dx_number' do
            element :answer, :css, 'td'
          end
          section :mobile, :et1_review_question_labelled, 'review.representative.questions.mobile' do
            element :answer, :css, 'td'
          end
          section :preferred_contact, :et1_review_question_labelled, 'review.representative.questions.preferred_contact' do
            element :answer, :css, 'td'
          end
          section :phone, :et1_review_question_labelled, 'review.representative.questions.phone' do
            element :answer, :css, 'td'
          end
          section :organisation_name, :et1_review_question_labelled, 'review.representative.questions.organisation_name' do
            element :answer, :css, 'td'
          end
          section :representative, :et1_review_question_labelled, 'review.representative.questions.representative' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(representative:)
            if representative.nil?
              expect(representative).to have_answer(text: t('review.common.no'))
            else
              aggregate_failures 'validating representative section' do
                expect(type_of_representative).to have_answer(text: with_not_entered(factory_translate representative.type))
                expect(email).to have_answer(text: with_not_entered(representative.email_address))
                expect(address).to have_answer_for(representative)
                expect(full_name).to have_answer(text: with_not_entered(representative.name))
                expect(dx_number).to have_answer(text: with_not_entered(representative.dx_number))
                expect(mobile).to have_answer(text: with_not_entered(representative.alternative_telephone_number))
                expect(phone).to have_answer(text: with_not_entered(representative.telephone_number))
                expect(preferred_contact).to have_answer(text: with_not_entered(nil)) # ET1 outputs not entered always ! (data not collected)
                expect(organisation_name).to have_answer(text: with_not_entered(representative.organisation_name))
                expect(self).to have_no_representative
              end
            end
            true
          end
        end
      end
    end
  end
end
