require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class YourRepresentativePage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Your representative page
        section :main_header, '.content-header' do
          element :header, :content_header, 'your_representative.header'
        end
        section :have_representative_question, :single_choice_option, 'questions.have_representative.label', exact: true do
          include ::EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.have_representative.yes.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.have_representative.no.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          def set_for(user_persona)
            choose(factory_translate(user_persona.have_representative), name: 'your_representative[have_representative]')
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
