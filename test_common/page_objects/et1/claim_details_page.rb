require_relative './base_page'
require_relative '../../../test_common/helpers/upload_helper'
module EtFullSystem
  module Test
    module Et1
      class ClaimDetailsPage < BasePage
        include RSpec::Matchers
        #Claim details
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.claim_details.header', exact: false
        end
        section :main_content, '#content .main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end
          #Describe your claim
          element :describe_your_claim, :legend_header, 'claims.claim_details.claim_details'
          #Write your claim statement below. Include the background, dates and people involved. 
          element :describe_your_claim_info, :paragraph, 'claims.claim_details.claim_details_html', exact: false
          #More about writing your claim statement.
          element :about_claim_info, :link_named, 'claims.claim_details.claim_details_hint', exact: false
          #Or upload it as a separate document
          element :upload_document, :summary_text, 'claims.claim_details.claim_details_upload' do
            element :selector, :css, '.summary'
            def set(*args); selector.set(*args); end
          end
          section :claim_details_claim_details_rtf, '.claim_details_claim_details_rtf' do
            #The document needs to be in Rich Text Format(RTF) (optional)
            element :claim_details_claim_details_rtf_info, :form_labelled, 'simple_form.labels.claim_details.claim_details_rtf', exact: false
            #You can usually save a file as RTF by selecting File> Save As> Export To> Format: Rich Text Format
            element :claim_details_claim_details_rtf_hint, :form_hint, 'simple_form.hints.claim_details.claim_details_rtf', exact: false
          end
          section :file_upload, 'input#claim_details_claim_details_rtf' do
            include ::EtFullSystem::Test::UploadHelper
            def set(value)
              force_remote do
                full_path = File.expand_path(File.join('test_common', 'fixtures', value))
                root_element.set(full_path)
              end
            end
          end
          #Limit is 2500 characters. (2500 characters remaining)
          section :claim_details_claim_details, '.claim_details_claim_details' do
            element :blank_claim_details_claim_details, :error, 'activemodel.errors.models.claim_details.attributes.claim_details.blank'
            element :claim_details_claim_details_hint, :form_hint, 'claims.claim_details.claim_details_hint_html'
            element :field, :css, 'textarea'
            def set(*args); field.set(*args); end
          end
          #Similar claims
          section :claim_details_other_known_claimants, :legend_header, 'claims.claim_details.similar_claims' do
            #Do you know of any other claimants (not already listed) making similar claims against the same employer? (optional)
            element :claim_details_other_known_claimants_label, :form_labelled, 'simple_form.labels.claim_details.other_known_claimants'
            #A judge may combine similar claims to manage and hear them together. This may save you and the tribunal time and money.
            element :claim_details_other_known_claimants_hint , :form_hint, 'simple_form.hints.claim_details.other_known_claimants'
            include ::EtFullSystem::Test::I18n
            element :yes, :form_labelled, 'claims.claim_type.yes' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'claims.claim_type.no' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'claim_details[other_known_claimants]')
            end
          end
          #You can add the names of other people here. (optional)
          section :other_known_claimant_names, '.claim_details_other_known_claimant_names' do
            element :claim_details_other_known_claimant_names, :form_labelled, 'simple_form.labels.claim_details.other_known_claimant_names', exact: false
            #Limit is 350 characters. (350 characters remaining)
            element :claim_details_other_known_claimant_names_hint, :form_hint, 'simple_form.hints.claim_details.other_known_claimants', exact: false
            element :field, :css, 'textarea'
            def set(*args); field.set(*args); end
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

        def has_mandatory_error_message?
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.claim_details_claim_details).to have_blank_claim_details_claim_details
        end

        def has_correct_translation?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Claim details
          expect(main_header).to have_page_header
          #Describe your claim
          expect(main_content).to have_describe_your_claim_info
          expect(main_content).to have_about_claim_info
          expect(main_content).to have_upload_document
          expect(main_content.claim_details_claim_details_rtf).to have_claim_details_claim_details_rtf_info
          expect(main_content.claim_details_claim_details_rtf).to have_claim_details_claim_details_rtf_hint
          #Limit is 2500 characters. (2500 characters remaining)
          expect(main_content).to have_claim_details_other_known_claimants
          expect(main_content.claim_details_other_known_claimants).to have_claim_details_other_known_claimants_label
          expect(main_content.claim_details_other_known_claimants).to have_claim_details_other_known_claimants_hint
          expect(main_content.claim_details_other_known_claimants).to have_yes
          expect(main_content.claim_details_other_known_claimants).to have_no
          #You can add the names of other people here. (optional)
          expect(main_content.other_known_claimant_names).to have_claim_details_other_known_claimant_names
          expect(main_content.other_known_claimant_names).to have_claim_details_other_known_claimant_names
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

        def set(claim)
          data = claim.to_h
          return if claim.nil?
          if data.key?(:rtf_file)
            main_content.upload_document.click
            main_content.file_upload.set(data[:rtf_file])
          end
          main_content.claim_details_claim_details.set(data[:description])
          main_content.claim_details_other_known_claimants.set(data[:other_claimants])
          main_content.other_known_claimant_names.set(data[:other_claimant_names]) if data.key?(:other_claimant_names)
        end
      end
    end
  end
end
