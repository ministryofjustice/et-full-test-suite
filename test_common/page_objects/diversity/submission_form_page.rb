require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class SubmissionFormPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        #Check your answers
        element :header, :main_header, 'diversities.review.hint'
        section :main_content, '#content .main-section .main-content' do
          #What is the type of your claim?
          section :claim_type_row, :table_row_with_th_labelled, 'summary.claim' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your sex?
          section :sex_row, :table_row_with_th_labelled, 'summary.sex' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your gender identity?
          section :gender_row, :table_row_with_th_labelled, 'summary.gender' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Is your gender identity different to the sex you were assumed to be at birth?
          section :gender_at_birth_row, :table_row_with_th_labelled, 'summary.gender_at_birth' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Which of the options below best describes your sexual identity?
          section :sexual_identity_row, :table_row_with_th_labelled, 'summary.sexual_identity' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your relationship status?
          section :relationship_row, :table_row_with_th_labelled, 'summary.relationship' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Which age group are you in?
          section :age_row, :table_row_with_th_labelled, 'summary.age' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Do you have any caring responsibilities?
          section :care_row, :table_row_with_th_labelled, 'summary.care' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your religion?
          section :religion_row, :table_row_with_th_labelled, 'summary.religion' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your ethnic group?
          section :ethnicity_group_row, :table_row_with_th_labelled, 'summary.ethnicity_group' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #What is your ethnic type?
          section :ethnicity_type_row, :table_row_with_th_labelled, 'summary.ethnicity_type' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Do you have any physical or mental health conditions or illnesses lasting or expected to last for 12 months or more?
          section :health_row, :table_row_with_th_labelled, 'summary.health' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Were you pregnant when you were dismissed?
          section :pregnancy_row, :table_row_with_th_labelled, 'summary.pregnancy' do
            element :answer, :css, 'td'
            element :link, :link_named, 'diversities.edit'
          end
          #Submit form
          element :submit_form, :submit_text, 'diversities.show.submit'
        end

        def submit_form
          main_content.submit_form.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_data_populated?(diversity)
          data = diversity_data?(diversity)
          expect(feedback_notice).to have_language
          expect(self).to have_header
          expect(main_content.claim_type_row).to have_answer(text: data[:claim_type])
          expect(main_content.sex_row).to have_answer(text: data[:sex])
          expect(main_content.gender_row).to have_answer(text: data[:gender])
          expect(main_content.gender_at_birth_row).to have_answer(text: data[:gender_at_birth])
          expect(main_content.sexual_identity_row).to have_answer(text: data[:sexual_identity])
          expect(main_content.relationship_row).to have_answer(text: data[:relationship])
          expect(main_content.age_row).to have_answer(text: data[:age_group])
          expect(main_content.care_row).to have_answer(text: data[:caring_responsibility])
          expect(main_content.religion_row).to have_answer(text: data[:religion])
          expect(main_content.ethnicity_group_row).to have_answer(text: data[:ethnicity])
          expect(main_content.ethnicity_type_row).to have_answer(text: data[:ethnicity_type]) if data[:ethnicity_type] != nil
          expect(main_content.health_row).to have_answer(text: data[:disability])
          expect(main_content.pregnancy_row).to have_answer(text: data[:pregnancy])
        end

        def diversity_data?(diversity)
          return diversity.to_h.inject({}) do |acc, (k,v)|
            acc[k] = factory_translate(v)
            acc
          end
        end

      end
    end
  end
end