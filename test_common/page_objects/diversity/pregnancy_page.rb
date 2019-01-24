require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class PregnancyPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          #Were you pregnant when you were dismissed?
          element :header, :main_header, 'diversities.pregnancy.hint'
          section :yes, :form_labelled, 'pregnancy.yes_answer' do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :no, :form_labelled, 'pregnancy.no_answer' do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :prefer_not_to_say, :form_labelled, 'pregnancy.prefer-not-to-say' do
            element :field, 'input'
            def set(*args); field.set(*args); end
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
          data = answers.to_h
          if data[:pregnancy] != nil
            choose(factory_translate(data[:pregnancy]), name: 'diversities_pregnancy[pregnancy]')
          end
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(main_content).to have_header
          expect(main_content).to have_yes
          expect(main_content).to have_no
          expect(main_content).to have_prefer_not_to_say
        end
      end
    end
  end
end
