require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class SexualIdentityPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          #How do you identify?
          element :header, :main_header, 'diversities.identity.hint', exact: false
          section :sex, :question_labelled, 'diversities.identity.sex.hint' do
            section :male, :form_labelled, 'sex.male' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :female, :form_labelled, 'sex.female' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'sex.prefer-not-to-say' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
          end
          section :gender, :question_labelled, 'diversities.identity.gender.hint' do
            section :male, :form_labelled, 'gender.male-including-female-to-male-trans-men' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :female, :form_labelled, 'gender.female-including-male-to-female-trans-women' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'gender.prefer-not-to-say' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
          end
          section :gender_at_birth, :question_labelled, 'diversities.identity.gender_at_birth.hint' do
            section :yes, :form_labelled, 'gender_at_birth.yes_answer' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :no, :form_labelled, 'gender_at_birth.no_answer' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'gender_at_birth.prefer-not-to-say' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
          end
          section :your_sexual_identity, :question_labelled, 'diversities.identity.sexual_identity.hint' do
            section :heterosexual, :form_labelled, 'sexual_identity.heterosexual-straight' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :gay, :form_labelled, 'sexual_identity.gay-lesbian' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :bisexual, :form_labelled, 'sexual_identity.bisexual' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :other, :form_labelled, 'sexual_identity.other' do
              element :field, 'input'
              def set(*args); field.set(*args); end
            end
            section :prefer_not_to_say, :form_labelled, 'sexual_identity.prefer-not-to-say' do
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
          set_for_optional(answers, :sex, 'diversities_identity[sex]')
          set_for_optional(answers, :gender, 'diversities_identity[gender]')
          set_for_optional(answers, :gender_at_birth, 'diversities_identity[gender_at_birth]')
          set_for_optional(answers, :sexual_identity, 'diversities_identity[sexual_identity]')
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(main_content).to have_header
          #What is your sex? (optional)
          expect(main_content).to have_sex
          expect(main_content.sex).to have_male
          expect(main_content.sex).to have_female
          expect(main_content.sex).to have_prefer_not_to_say
          #What is your gender identity? (optional)
          expect(main_content).to have_gender
          expect(main_content.gender).to have_male
          expect(main_content.gender).to have_female
          expect(main_content.gender).to have_prefer_not_to_say
          #Is your gender identity different to the sex you were assumed to be at birth? (optional)
          expect(main_content).to have_gender_at_birth
          expect(main_content.gender_at_birth).to have_yes
          expect(main_content.gender_at_birth).to have_no
          expect(main_content.gender_at_birth).to have_prefer_not_to_say
          #Which of the options below best describes your sexual identity? (optional)
          expect(main_content).to have_your_sexual_identity
          expect(main_content.your_sexual_identity).to have_heterosexual
          expect(main_content.your_sexual_identity).to have_gay
          expect(main_content.your_sexual_identity).to have_bisexual
          expect(main_content.your_sexual_identity).to have_other
          expect(main_content.your_sexual_identity).to have_prefer_not_to_say
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
