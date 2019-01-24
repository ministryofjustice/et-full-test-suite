require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class EmployersContractClaimPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_header, '.content-header' do
          element :header, :content_header, 'employer_contract_claim.header'
        end
        element :error_header, :error_titled, 'errors.header', exact: true
        section :make_employer_contract_claim_question, :single_choice_option, 'questions.make_employer_contract_claim.label', exact: true do
          include ::EtFullSystem::Test::I18n
          section :no, :gds_multiple_choice_option, 'questions.make_employer_contract_claim.no.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :yes, :gds_multiple_choice_option, 'questions.make_employer_contract_claim.yes.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :claim_information, :textarea_labelled, 'questions.make_employer_contract_claim.claim_information.label', exact: true do
            def set(*args); root_element.set(*args); end
          end
          element :error_too_long, :exact_error_text, 'errors.messages.too_long', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.make_employer_contract_claim), name: 'employers_contract_claim[make_employer_contract_claim]')
            if user_persona.make_employer_contract_claim.to_s.split('.')[-2] == 'yes'
              claim_information.set(user_persona.claim_information)
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
