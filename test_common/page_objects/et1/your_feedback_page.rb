require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class YourFeedbackPage < BasePage
        include RSpec::Matchers
        section 'flash_heading', '#flash-summary' do
          element :flash_message, :content_header, 'feedback.create.sent'
        end
        #your feedback header
        element :header, :main_header, 'feedback.new.header'
        section :main_content, '.main-section, .main-content' do
          #have you had any problems using this service? (optional)
          section :comments, :question_labelled, 'simple_form.labels.feedback.comments', exact: false do
            element :field, :css, "textarea"
            def set(*args); field.set(*args); end
          end
          #do you have any other comments or suggestions? (optional)
          section :suggestions, :question_labelled, 'simple_form.labels.feedback.suggestions', exact: false do
            element :field, :css, "textarea"
            def set(*args); field.set(*args); end
          end
          #your email address (optional)
          section :email_address, :question_labelled, 'simple_form.labels.feedback.email_address', exact: false do
            element :field, :css, "input"
            def set(*args); field.set(*args); end
          end
        end
        #send feedback
        section :form_actions, '.form-actions' do
          element :submit_feedback, :submit_text, 'helpers.submit.feedback.create'
        end
        #Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
        end

        def send_your_feedback
          form_actions.submit_feedback.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end
        
        def has_correct_translation?
          #your feedback header
          expect(self).to have_header
          #body text
          expect(main_content).to have_comments
          expect(main_content).to have_suggestions
          expect(main_content).to have_email_address
          #Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
        end
      end
    end
  end
end
