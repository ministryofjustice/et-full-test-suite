require_relative './base_page'
require_relative '../../../test_common/helpers/upload_helper'
module EtFullSystem
  module Test
    module Et1
      class GroupClaimantsUploadPage < BasePage
        include RSpec::Matchers
        #Group claims
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.additional_claimants.header', exact: false
        end
        section :main_content, '.main-section .main-content' do
          section :error_message, '#edit_claimant #error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message'
          end
          #People making a claim with you
          element :people_making_claim, :legend_header, 'claims.additional_claimants.subheader'
          section :form_group, '.form-group-reveal' do
            element :has_additional_claimants, :form_labelled, 'simple_form.labels.additional_claimants_upload.has_additional_claimants'
            element :form_hint_text, :paragraph, 'claims.additional_claimants_upload.has_additional_claimants_html', exact: false
            element :manually_link, :link_named, 'claims.additional_claimants_upload.has_additional_claimants_link', exact: false
            include ::EtFullSystem::Test::I18n
            element :yes, :form_labelled, 'simple_form.yes' do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'simple_form.no' do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
          end

          #Spreadsheet for group claim
          section :group_claims, :legend_header, 'claims.additional_claimants_upload.steps_header' do
            #Step 1
            element :step_1, :break_text, 'claims.additional_claimants_upload.step_one_header'
            element :download_spreadsheet_template_link, :link_named, 'claims.additional_claimants_upload.download_template_html', exact: false
            element :use_your_own_text, :paragraph, 'claims.additional_claimants_upload.use_your_own_text', exact: false
            element :dob_info, :paragraph, 'claims.additional_claimants_upload.dob_info'
            #Step 2
            element :step_2, :break_text, 'claims.additional_claimants_upload.step_two_header'
            element :save_csv_format_text, :paragraph, 'claims.additional_claimants_upload.save_csv_format', exact: false
            element :how_to_save, :paragraph, 'claims.additional_claimants_upload.how_to_save'
            element :no_spaces, :paragraph, 'claims.additional_claimants_upload.no_spaces', exact: false
            #Step 3
            element :step_3, :break_text, 'claims.additional_claimants_upload.step_three_header'
            element :file_spreadsheet_labelled, :form_labelled, 'simple_form.labels.additional_claimants_upload.additional_claimants_csv', exact: false
            section :file_upload, 'input#additional_claimants_upload_additional_claimants_csv' do
              include ::EtFullSystem::Test::UploadHelper
              def set(value)
                force_remote do
                  full_path = File.expand_path(File.join('test_common', 'fixtures', value))
                  root_element.set(full_path)
                end
              end
            end
            #Maximum file size is 2MB
            element :upload_limit, :paragraph, 'claims.additional_claimants_upload.upload_limit', exact: false
          end
          #Save and continue
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation_for_group_claimants?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Group claims
          expect(main_header).to have_page_header
          #people making a claim with you
          expect(main_content).to have_people_making_claim
          #Do you want to upload details of 6 claimants or more? (optional)
          expect(main_content.form_group).to have_has_additional_claimants
          #For up to 5 other claimants you can enter their details manually
          expect(main_content.form_group).to have_form_hint_text
          expect(main_content.form_group).to have_manually_link
          expect(main_content.form_group).to have_yes
          expect(main_content.form_group).to have_no
          #Spreadsheet for group claim
          expect(main_content).to have_group_claims
          expect(main_content.group_claims).to have_step_1
          expect(main_content.group_claims).to have_download_spreadsheet_template_link
          expect(main_content.group_claims).to have_use_your_own_text
          expect(main_content.group_claims).to have_dob_info
          expect(main_content.group_claims).to have_step_2
          expect(main_content.group_claims).to have_save_csv_format_text
          expect(main_content.group_claims).to have_how_to_save
          expect(main_content.group_claims).to have_no_spaces
          expect(main_content.group_claims).to have_step_3
          expect(main_content.group_claims).to have_file_spreadsheet_labelled
          expect(main_content.group_claims).to have_upload_limit
          #save and continue
          expect(main_content).to have_save_and_continue_button
          #Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          #Save your claim later
          expect(support).to have_your_claim
          #TODO this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end
        
        def set(user)
          group_claims_csv = user[0].dig(:group_claims_csv)
          if group_claims_csv.present?
            main_content.form_group.yes.click
            main_content.group_claims.file_upload.set(group_claims_csv)
          else
            main_content.form_group.no.click
          end
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end
      end
    end
  end
end
