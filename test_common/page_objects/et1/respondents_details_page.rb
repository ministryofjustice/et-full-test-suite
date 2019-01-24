require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class RespondentsDetailsPage < BasePage
        include RSpec::Matchers
        #Respondent's details
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.respondent.header', exact: false
        end
        section :main_content, '.main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end
          #About the respondent
          element :respondent_header, :legend_header, 'claims.respondent.respondent_legend'
          element :respondent_summary, :paragraph, 'claims.respondent.form_hint'
          element :blank_respondent_name, :error, 'activemodel.errors.models.respondent.attributes.name.blank'
          section :name, :question_labelled, 'simple_form.labels.respondent.name' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_building, :error, 'activemodel.errors.models.respondent.attributes.address_building.blank'
          section :building, :question_labelled, 'simple_form.labels.respondent.address_building' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_street, :error, 'activemodel.errors.models.respondent.attributes.address_building.blank'
          section :street, :question_labelled, 'simple_form.labels.respondent.address_street' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_locality, :error, 'activemodel.errors.models.respondent.attributes.address_street.blank'
          section :locality, :question_labelled, 'simple_form.labels.respondent.address_locality' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_county, :error, 'activemodel.errors.models.respondent.attributes.address_locality.blank'
          element :county_hint, :paragraph, 'simple_form.hints.respondent.address_county', exact: false
          section :county, :question_labelled, 'simple_form.labels.respondent.address_county' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_post_code, :error, 'activemodel.errors.models.respondent.attributes.address_post_code.blank'
          element :invalid_post_code, :error, 'activemodel.errors.models.respondent.attributes.address_post_code.invalid'
          section :post_code, :question_labelled, 'simple_form.labels.respondent.address_post_code' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          section :telephone_number, :question_labelled, 'simple_form.labels.respondent.address_telephone_number' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          #Your work address
          element :work_address_header, :legend_header, 'claims.respondent.workaddress_legend'
          section :same_address, '.respondent_worked_at_same_address' do
            include ::EtFullSystem::Test::I18n
            element :work_address_labelled, :form_labelled, 'simple_form.labels.respondent.worked_at_same_address'
            element :yes, :form_labelled, 'simple_form.labels.respondent.yes' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'simple_form.labels.respondent.no' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'respondent[worked_at_same_address]')
            end
          end
          #Your work address
          section :work_address, '#work_address_wrapper' do
            element :work_address_hint, :paragraph, 'claims.respondent.work_address'
            element :blank_building, :error, 'activemodel.errors.models.respondent.attributes.work_address_building.blank'
            section :building, :question_labelled, 'simple_form.labels.respondent.work_address_building' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :blank_street, :error, 'activemodel.errors.models.respondent.attributes.work_address_street.blank'
            section :street, :question_labelled, 'simple_form.labels.respondent.work_address_street' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :blank_locality, :error, 'activemodel.errors.models.respondent.attributes.work_address_locality.blank'
            section :locality, :question_labelled, 'simple_form.labels.respondent.work_address_locality' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :county_hint, :paragraph, 'simple_form.hints.respondent.address_county', exact: false
            section :county, :question_labelled, 'simple_form.labels.respondent.work_address_county' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :blank_post_code, :error, 'activemodel.errors.models.respondent.attributes.work_address_post_code.blank'
            section :post_code, :question_labelled, 'simple_form.labels.respondent.work_address_post_code' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            section :telephone_number, :question_labelled, 'simple_form.labels.respondent.work_address_telephone_number' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
          end
          #Acas early conciliation certificate number
          element :acas_early_conciliation_header, :legend_header, 'claims.respondent.acas_legend'
          section :acas_certificate_number, '.respondent_acas_early_conciliation_certificate_number' do
            element :acas_hint, :paragraph, 'claims.respondent.acas_early_conciliation_certificate_number_html', exact: false
            element :certificate_number, :link_named, 'claims.respondent.acas_early_conciliation_certificate_number_link', exact: false
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          #I don't have an Acas number
          element :no_acas_number, :form_labelled, 'simple_form.labels.respondent.no_acas_number' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          #Why don't you have an Acas number?
          element :no_acas_number_reason, :legend_header, 'claims.respondent.no_acas_number_reason'
          element :no_acas_number_note_one, :form_hint, 'claims.respondent.no_acas_number_note_one', exact: false
          section :respondent_no_acas_number_reason, '.respondent_no_acas_number_reason' do
            include ::EtFullSystem::Test::I18n
            element :blank_no_acas_number_reason, :error, 'activemodel.errors.models.respondent.attributes.no_acas_number_reason.blank'
            element :joint_claimant_has_acas_number, :form_labelled, 'simple_form.options.respondent.no_acas_number_reason.joint_claimant_has_acas_number' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :acas_has_no_jurisdiction, :form_labelled, 'simple_form.options.respondent.no_acas_number_reason.acas_has_no_jurisdiction' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :employer_contacted_acas, :form_labelled, 'simple_form.options.respondent.no_acas_number_reason.employer_contacted_acas' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :interim_relief, :form_labelled, 'simple_form.options.respondent.no_acas_number_reason.interim_relief' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'respondent[no_acas_number_reason]')
            end
          end
          #Save and continue
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Respoondent's details
          expect(main_header).to have_page_header
          #About the respondent
          expect(main_content).to have_respondent_header
          expect(main_content).to have_respondent_summary
          #Respondent contact details
          expect(main_content).to have_name
          expect(main_content).to have_building
          expect(main_content).to have_street
          expect(main_content).to have_locality
          expect(main_content).to have_county
          expect(main_content).to have_county_hint
          expect(main_content).to have_post_code
          expect(main_content).to have_telephone_number
          #Your work address
          expect(main_content).to have_work_address_header
          expect(main_content.same_address).to have_work_address_labelled
          expect(main_content.same_address).to have_yes
          expect(main_content.same_address).to have_no
          #Different work address
          expect(main_content.work_address).to have_work_address_hint
          expect(main_content.work_address).to have_building
          expect(main_content.work_address).to have_street
          expect(main_content.work_address).to have_locality
          expect(main_content.work_address).to have_county
          expect(main_content.work_address).to have_county_hint
          expect(main_content.work_address).to have_post_code
          expect(main_content.work_address).to have_telephone_number
          #Acas early conciliation certifcate number
          expect(main_content).to have_acas_early_conciliation_header
          expect(main_content.acas_certificate_number).to have_acas_hint
          expect(main_content.acas_certificate_number).to have_certificate_number
          #I don't have an acas number
          expect(main_content).to have_no_acas_number
          #Why don't you have an Acas number?
          expect(main_content).to have_no_acas_number_reason
          expect(main_content).to have_no_acas_number_note_one
          expect(main_content.respondent_no_acas_number_reason).to have_joint_claimant_has_acas_number
          expect(main_content.respondent_no_acas_number_reason).to have_acas_has_no_jurisdiction
          expect(main_content.respondent_no_acas_number_reason).to have_employer_contacted_acas
          expect(main_content.respondent_no_acas_number_reason).to have_interim_relief
          #Save and continue
          expect(main_content).to have_save_and_continue_button
          #Support
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          #Save your claim later
          expect(support).to have_your_claim
          #TODO this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def has_correct_blank_validation_error_messages?
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content).to have_blank_respondent_name
          expect(main_content).to have_blank_building
          expect(main_content).to have_blank_street
          expect(main_content).to have_blank_locality
          expect(main_content).to have_blank_county
          expect(main_content).to have_blank_post_code
          expect(main_content.work_address).to have_blank_building
          expect(main_content.work_address).to have_blank_street
          expect(main_content.work_address).to have_blank_locality
          expect(main_content.work_address).to have_blank_post_code
          expect(main_content.respondent_no_acas_number_reason).to have_blank_no_acas_number_reason
        end

        def has_correct_error_message_for_invalid_uk_postcode?
          expect(main_content).to have_invalid_post_code
        end

        def set(respondent)
          data = respondent[0].to_h
          return if data.nil? || data.empty?
          main_content do |s|
            set_field s, :name, data
            set_field s, :building, data
            set_field s, :street, data
            set_field s, :locality, data
            set_field s, :county, data
            set_field s, :post_code, data
            set_field s, :telephone_number, data
          end
          if data.key?(:work_building)
            main_content.same_address.no.click
            main_content.work_address do |s|
              s.building.set(data[:work_building])
              s.street.set(data[:work_street])
              s.locality.set(data[:work_locality])
              s.county.set(data[:work_county])
              s.post_code.set(data[:work_post_code])
              s.telephone_number.set(data[:work_telephone_number])
            end
          else
            main_content.same_address.yes.click
          end
          main_content.acas_certificate_number.set(data[:acas_number]) if data.key?(:acas_number)
          if data.key?(:no_acas_number_reason)
            main_content.no_acas_number.click
            main_content.respondent_no_acas_number_reason.set(data[:no_acas_number_reason])
          end
        end

        private

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
