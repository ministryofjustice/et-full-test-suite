require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class GroupClaimantsPage < BasePage
        include RSpec::Matchers
        #Group claims
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.additional_claimants.header', exact: false
        end
        section :main_content, '.main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end

          #People making a claim with you
          element :legend_group_claims, :legend_header, 'claims.additional_claimants.subheader', exact: false
          section :additional_claimants_of_collection_type, '.additional_claimants_of_collection_type' do
            include ::EtFullSystem::Test::I18n
            element :group_claims, :form_labelled, 'simple_form.labels.additional_claimants.of_collection_type'
            element :yes, :form_labelled, 'simple_form.yes' do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'simple_form.no' do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
          end

          section :number_claimants_info, '#number_claimants_info' do
            element :five_more_claimants, :panel_indent, 'claims.additional_claimants.number_claimants_info', exact: false
            element :six_more_claimants, :panel_indent, 'claims.additional_claimants.csv_upload_text_html', exact: false
            element :csv_upload_link, :link_named, 'claims.additional_claimants.csv_upload_link', exact: false
          end

          section :about_claimant_2, GroupClaimantSection, :group_claimants, "claims.additional_claimants.person", number: 2
          section :about_claimant_3, GroupClaimantSection, :group_claimants, "claims.additional_claimants.person", number: 3
          section :about_claimant_4, GroupClaimantSection, :group_claimants, "claims.additional_claimants.person", number: 4
          section :about_claimant_5, GroupClaimantSection, :group_claimants, "claims.additional_claimants.person", number: 5
          section :about_claimant_6, GroupClaimantSection, :group_claimants, "claims.additional_claimants.person", number: 6

          element :add_more_claimants_link, :submit_text, 'claims.additional_claimants.add_fields'
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def add_more_claimants
          main_content.add_more_claimants_link.click
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        def has_correct_translation_on_group_claims?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Group claims
          expect(main_header).to have_page_header
          #people making a claim with you
          expect(main_content).to have_legend_group_claims
          expect(main_content.additional_claimants_of_collection_type).to have_group_claims
          expect(main_content.additional_claimants_of_collection_type).to have_yes
          expect(main_content.additional_claimants_of_collection_type).to have_no
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

        def has_correct_translation_for_group_claimants?
          #For 5 or fewer claimants, enter their details below
          expect(main_content.number_claimants_info).to have_five_more_claimants
          #For 6 or more claimants, you can upload their details in a separate spreadsheet.
          expect(main_content.number_claimants_info).to have_six_more_claimants
          expect(main_content.number_claimants_info).to have_csv_upload_link
          #Claimant 2
          expect(main_content.about_claimant_2).to have_title
          expect(main_content.about_claimant_2).to have_first_name
          expect(main_content.about_claimant_2).to have_last_name
          #date of birth
          expect(main_content.about_claimant_2).to have_date_of_birth_labelled
          expect(main_content.about_claimant_2).to have_date_of_birth_hint
          expect(main_content.about_claimant_2.date_of_birth).to have_day
          expect(main_content.about_claimant_2.date_of_birth).to have_month
          expect(main_content.about_claimant_2.date_of_birth).to have_year
          expect(main_content.about_claimant_2).to have_building
          expect(main_content.about_claimant_2).to have_street
          expect(main_content.about_claimant_2).to have_locality
          expect(main_content.about_claimant_2).to have_county
          expect(main_content.about_claimant_2).to have_post_code
          #Add more claimants
          expect(main_content).to have_add_more_claimants_link
        end

        def has_correct_mandatory_error_msg_for_group_claimants?
          #Errors on page
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.about_claimant_2.title).to have_blank_title
          expect(main_content.about_claimant_2.first_name).to have_blank_first_name
          expect(main_content.about_claimant_2.last_name).to have_blank_last_name
          expect(main_content.about_claimant_2).to have_blank_date_of_birth
          expect(main_content.about_claimant_2).to have_blank_building
          expect(main_content.about_claimant_2).to have_blank_street
          expect(main_content.about_claimant_2).to have_blank_locality
          expect(main_content.about_claimant_2).to have_blank_county
          expect(main_content.about_claimant_2).to have_blank_post_code
        end

        def has_correct_invalid_error_msg_for_dob?
          expect(main_content.about_claimant_2).to have_invalid_date_of_birth
        end

        def set(data)
          group_claims_csv = data[0].dig(:group_claims_csv)
          if data.length > 1 || group_claims_csv.present?
            main_content.additional_claimants_of_collection_type.yes.click
            data.drop(1).each.with_index do |claimant, idx|
              add_more_claimants unless idx == 0
              populate_group_claim_section(claimant.to_h, idx + 2)
            end
            main_content.number_claimants_info.csv_upload_link.click if group_claims_csv.present?
          else
            main_content.additional_claimants_of_collection_type.no.click
          end
        end

        private

        def upload_page
          AdditionalClaimantsUploadPage.new
        end

        def populate_group_claim_section(claimant_data, claimant_number)
          s = main_content.send(:"about_claimant_#{claimant_number}")
          set_field s, :title, claimant_data
          set_field s, :first_name, claimant_data
          set_field s, :last_name, claimant_data
          set_field s, :date_of_birth, claimant_data
          set_field s, :building, claimant_data
          set_field s, :street, claimant_data
          set_field s, :locality, claimant_data
          set_field s, :county, claimant_data
          set_field s, :post_code, claimant_data
        end

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end

      end
    end
  end
end
