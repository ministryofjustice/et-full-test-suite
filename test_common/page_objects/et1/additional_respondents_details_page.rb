require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class AdditionalRespondentsDetailsPage < BasePage
        include RSpec::Matchers
        #Additional respondents
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.additional_respondents.header', exact: false
        end
        section :main_content, '#content .main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end
          #Claims against more than one employer
          element :additional_respondents_header, :legend_header, 'claims.additional_respondents.additional_respondents_legend'
          #Are you making a claim against another person or organisation?
          element :additional_respondents_intro, :paragraph, 'claims.additional_respondents.additional_respondents_intro'
          section :additional_respondents, '.additional_respondents_of_collection_type' do
            include ::EtFullSystem::Test::I18n
            element :yes, :form_labelled, 'claims.additional_respondents.yes' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'claims.additional_respondents.no' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'additional_respondents[of_collection_type]')
            end
          end

          section :respondent_2, AdditionalRespondentSection, :group_claimants, "claims.additional_respondents.person", number: 2
          section :respondent_3, AdditionalRespondentSection, :group_claimants, "claims.additional_respondents.person", number: 3
          section :respondent_4, AdditionalRespondentSection, :group_claimants, "claims.additional_respondents.person", number: 4
          section :respondent_5, AdditionalRespondentSection, :group_claimants, "claims.additional_respondents.person", number: 5
          section :respondent_6, AdditionalRespondentSection, :group_claimants, "claims.additional_respondents.person", number: 6
          
          #Add another respondent
          element :add_another_respondent, :submit_text, 'claims.additional_respondents.add_fields'
          #Remove another respondent
          element :remove_another_respondent, :remove_multiple, 'claims.additional_respondents.remove_resource_link'
          #Save and continue
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end

        def remove_another_respondent
          main_content.remove_another_respondent.click
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
          #Additional respondents
          expect(main_header).to have_page_header
          #Claims against more than one employer
          expect(main_content).to have_additional_respondents_header
          expect(main_content).to have_additional_respondents_intro
          expect(main_content.additional_respondents).to have_yes
          expect(main_content.additional_respondents).to have_no
          #Respondent details
          expect(main_content.respondent_2).to have_name
          expect(main_content.respondent_2).to have_building
          expect(main_content.respondent_2).to have_street
          expect(main_content.respondent_2).to have_locality
          expect(main_content.respondent_2).to have_county
          expect(main_content.respondent_2).to have_post_code
          #Acas number
          expect(main_content.respondent_2).to have_acas_number
          #I don't have an acas number
          expect(main_content.respondent_2).to have_no_acas_number
          expect(main_content.respondent_2).to have_no_acas_number_note_one
          expect(main_content.respondent_2.respondent_no_acas_number_reason).to have_joint_claimant_has_acas_number
          expect(main_content.respondent_2.respondent_no_acas_number_reason).to have_acas_has_no_jurisdiction
          expect(main_content.respondent_2.respondent_no_acas_number_reason).to have_employer_contacted_acas
          expect(main_content.respondent_2.respondent_no_acas_number_reason).to have_interim_relief
          #Add another respondent
          expect(main_content).to have_add_another_respondent
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

        def has_correct_blank_validation?
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.respondent_2).to have_blank_name
          expect(main_content.respondent_2).to have_blank_building
          expect(main_content.respondent_2).to have_blank_street
          expect(main_content.respondent_2).to have_blank_locality
          expect(main_content.respondent_2).to have_blank_county
          expect(main_content.respondent_2).to have_blank_post_code
          expect(main_content.respondent_2).to have_blank_acas_number
        end

        def has_correct_invalid_acas_number?
          expect(main_content.respondent_2).to have_invalid_acas_number
        end

        def has_correct_invalid_postcode?
          expect(main_content.respondent_2).to have_post_code
        end

        def set(respondents)
          return if respondents.nil? || respondents.empty?
          if respondents.length == 1
            main_content.additional_respondents.set(:"claims.additional_respondents.no")
          else
            main_content.additional_respondents.set(:"claims.additional_respondents.yes")
            main_content do |s|
              respondents[1..-1].each_with_index do |respondent, idx|
                s.add_another_respondent.click unless idx == 0
                populate_respondent s.send(:"respondent_#{idx + 2}"), respondent.to_h
              end
            end
          end
        end

        private

        def populate_respondent(section, respondent)
          set_field section, :name, respondent
          set_field section, :building, respondent
          set_field section, :street, respondent
          set_field section, :locality, respondent
          set_field section, :county, respondent
          set_field section, :post_code, respondent
          set_field section, :acas_number, respondent
        end

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
