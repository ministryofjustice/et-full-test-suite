require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ApplicationNumberPage < BasePage
        include RSpec::Matchers
        #page and main header
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.application_number.header'
        end
        section :main_content, '#content .main-section .main-content' do
          element :claim_number_text, :paragraph, 'claims.application_number.application_number'
          element :claims_number, '.callout-reference .number'
          element :claims_intro_text, :paragraph, 'claims.application_number.intro_text'
          #email address
          section :email_label, :question_labelled, 'simple_form.labels.application_number.email_address', exact: false do
            element :field, :css, "input"
            def set(*args); field.set(*args); end
          end
          #create your memorable word
          section :memorable_word_label, :question_labelled, 'simple_form.labels.application_number.password', exact: false do
            element :field, :css, "input"
            def set(*args); field.set(*args); end
          end
          element :example_word, :paragraph, 'simple_form.hints.application_number.password'
          #print this page
          element :print_link, :link_named, 'user_sessions.reminder.print_link'
          element :print_copy, :paragraph, 'claims.application_number.print_copy', exact: false
          #save and continue button
          element :save_and_continue, :submit_text, 'helpers.submit.update'
        end

        def switch_language
          feedback_notice.language.click
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

        def has_correct_translation?
          #saving your claim heading
          expect(main_header).to have_page_header
          #your claim number
          expect(main_content).to have_claim_number_text
          #claim intro
          expect(main_content).to have_claims_intro_text
          #email address
          expect(main_content).to have_email_label
          #memorable
          expect(main_content).to have_memorable_word_label
          #print this page
          expect(main_content).to have_print_link
          expect(main_content).to have_print_copy
          #save and continue button
          expect(main_content).to have_example_word
          #Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
        end


        def set(data)
          main_content.email_label.set(data[0].dig(:email_address))
          main_content.memorable_word_label.set(data[0].dig(:memorable_word))
        end
      end
    end
  end
end
