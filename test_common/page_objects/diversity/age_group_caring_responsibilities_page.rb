require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class AgeGroupCaringResponsibilitiesPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          #What is your age group and caring responsibilities?
          element :header, :main_header, 'diversities.age_caring.hint'
          section :age_group, :question_labelled, 'diversities.age_caring.age_group.hint' do
            section :u25, :form_labelled, 'age_group.under-25' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :age_25_34, :form_labelled, 'age_group.25-34' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :age_35_44, :form_labelled, 'age_group.35-44' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :age_45_54, :form_labelled, 'age_group.45-54' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :age_55_64, :form_labelled, 'age_group.55-64' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :over_65, :form_labelled, 'age_group.65-over' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'age_group.prefer-not-to-say' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
          end
          section :caring_responsibility, :question_labelled, 'diversities.age_caring.caring_responsibility.hint' do
            element :hint, :paragraph, 'diversities.age_caring.caring_responsibility.form_hint'
            section :yes, :form_labelled, 'caring_responsibility.yes_answer' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :no, :form_labelled, 'caring_responsibility.no_answer' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'caring_responsibility.prefer-not-to-say' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
          end
          #save and continue button
          element :save_and_continue, :submit_text, 'helpers.submit.update'
        end

        def save_and_continue
          main_content.save_and_continue.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def set_for(answers)
          set_for_optional(answers, :age_group, 'diversities_age_caring[age_group]')
          set_for_optional(answers, :caring_responsibility, 'diversities_age_caring[caring_responsibility]')
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(main_content).to have_header
          expect(main_content.age_group).to have_u25
          expect(main_content.age_group).to have_age_25_34
          expect(main_content.age_group).to have_age_35_44
          expect(main_content.age_group).to have_age_45_54
          expect(main_content.age_group).to have_age_55_64
          expect(main_content.age_group).to have_over_65
          expect(main_content.age_group).to have_prefer_not_to_say
          expect(main_content.caring_responsibility).to have_hint
          expect(main_content.caring_responsibility).to have_yes
          expect(main_content.caring_responsibility).to have_no
          expect(main_content.caring_responsibility).to have_prefer_not_to_say
        end

        private

        def set_for_optional(answers, key, name)
          data = answers.to_h
          if data[key] != nil
            choose(factory_translate(data[key]), name: name)
          end
        end
      end
    end
  end
end
