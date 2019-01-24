require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class ResponsePage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_header, '.content-header' do
          element :header, :content_header, 'response.header'
        end
        section :error_summary, '.error-summary' do
          element :error_heading, :main_header, 'errors.header'
          element :description, :paragraph, 'errors.description'
          element :error_header, :error_summary_list, 'errors.response.response_blank', exact: true
        end
        section :defend_claim_question, :single_choice_option, 'questions.defend_claim.label', exact: false do
          include ::EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.defend_claim.yes.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.defend_claim.no.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :defend_claim_facts, :textarea_labelled, 'questions.defend_claim.defend_claim_facts.label', exact: false do
            def set(*args); root_element.set(*args); end
          end
          element :error, :error_message, 'errors.response.response_blank'
          def set_for(user_persona)
            choose(factory_translate(user_persona.defend_claim), name: 'response[defend_claim]')
            if t(user_persona.defend_claim) == t('questions.defend_claim.yes.label')
              defend_claim_facts.set(user_persona.defend_claim_facts)
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
