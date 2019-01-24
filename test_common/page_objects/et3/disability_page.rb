require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class DisabilityPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_header, '.content-header' do
          element :header, :content_header, 'disability.header'
        end
        section :error_summary, '.error-summary' do
          element :error_heading, :main_header, 'errors.header'
          element :description, :paragraph, 'errors.description'
          element :error_header, :error_summary_list, 'errors.disability.disability_blank', exact: true
        end
        element :error_header, :error_titled, 'errors.header', exact: true
        section :disability_question, :single_choice_option, 'questions.disability.label', exact: false do
          include ::EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.disability.yes.label', exact: false do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.disability.no.label', exact: false do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          section :disability_information, :textarea_labelled, 'questions.disability.disability_information.label', exact: :false do
            def set(*args); root_element.set(*args); end
          end
          element :error_too_long, :exact_error_text, 'errors.messages.too_long', exact: false
          def set_for(user_persona)
            if(user_persona.disability != nil)
              choose(factory_translate(user_persona.disability), name: 'disability[disability]')
              if t(user_persona.disability) == t('questions.disability.yes.label') && user_persona.disability_information != nil
                disability_information.set(user_persona.disability_information)
              end
            end
          end
        end
        # Save and continue
        element :continue_button, :submit_text, 'components.save_and_continue_button'
        def next
          continue_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end

        def switch_to_english
          switch_language.english_link.click
        end
      end
    end
  end
end
