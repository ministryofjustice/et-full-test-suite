require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class RespondentsDetailsPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Respondent's Details
        element :header, :content_header, 'respondents_details.header'
        element :error_header, :error_titled, 'errors.header', exact: true
        # Case number
        section :case_number_question, :question_labelled, 'questions.case_number.label', exact: false do
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.respondents_details.case_number_invalid', exact: false
          def set(*args); field.set(*args); end
        end
        # Name of individual, company or organisation
        section :name_question, :question_labelled, 'questions.name.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.company_name', exact: false
          def set(*args); field.set(*args); end
        end
        # Name of contact (optional)
        # For example, John Smith
        section :contact_question, :question_labelled, 'questions.contact.label', exact: false do
          element :contact_hint, :form_hint, 'questions.contact.hint'
          element :field, :css, "input"
          element :error_contains_numbers, :exact_error_text, 'errors.respondents_details.contact_name_contain_numbers', exact: false
          element :error_contains_no_spaces, :exact_error_text, 'errors.respondents_details.contains_no_spaces', exact: false
          def set(*args); field.set(*args); end
        end
        # Building name or number
        section :building_name_question, :question_labelled, 'questions.building_name.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.building_name', exact: false
          def set(*args); field.set(*args); end
        end
        # Street
        section :street_question, :question_labelled, 'questions.street.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.street', exact: false
          def set(*args); field.set(*args); end
        end
        # Town/City
        section :town_question, :question_labelled, 'questions.town.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.town', exact: false
          def set(*args); field.set(*args); end
        end
        # County (optional)
        section :county_question, :question_labelled, 'questions.county.label', exact: false do
          element :field, :css, "input"
          def set(*args); field.set(*args); end
        end
        # Postcode
        section :postcode_question, :question_labelled, 'questions.postcode.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.postcode_blank', exact: false
          element :error_invalid, :exact_error_text, 'errors.respondents_details.postcode_invalid', exact: false
          def set(*args); field.set(*args); end
        end
        # Document exchange (DX) number (optional)
        section :dx_number_question, :question_labelled, 'questions.dx_number.label', exact: false do
          element :field, :css, "input"
          def set(*args); field.set(*args); end
        end
        # Contact number (optional)
        section :contact_number_question, :question_labelled, 'questions.contact_number.label', exact: false do
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.respondents_details.contact_number_invalid', exact: false
          def set(*args); field.set(*args); end
        end
        # Mobile number (optional)
        # If different to your primary contact numbe
        section :contact_mobile_number_question, :question_labelled, 'questions.contact_mobile_number.label', exact: false do
          element :mobile_hint, :form_hint, 'questions.contact_mobile_number.hint'
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.respondents_details.mobile_number_invalid', exact: false
          def set(*args); field.set(*args); end
        end
        # How would you prefer us to contact you? (optional)
        section :contact_preference_question, :single_choice_option, 'questions.contact_preference.label', exact: false do |q|
          include EtFullSystem::Test::I18n
          # Email
          section :select_email, :gds_multiple_choice_option, 'questions.contact_preference.email.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          # Post
          section :select_post, :gds_multiple_choice_option, 'questions.contact_preference.post.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          # Fax
          section :select_fax, :gds_multiple_choice_option, 'questions.contact_preference.fax.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          # Email address
          section :preference_email, :inputtext_labelled, 'questions.contact_preference.email.input_label' do
            def set(*args); root_element.set(*args); end
          end
          # Fax number
          section :preference_fax, :inputtext_labelled, 'questions.contact_preference.fax.input_label' do
            def set(*args); root_element.set(*args); end
          end
          element :error_invalid_email, :exact_error_text, 'errors.respondents_details.email_address_invalid', exact: false
          element :error_invalid_fax, :exact_error_text, 'errors.respondents_details.invalid', exact: false
          def set_for(user)
            if (user.contact_preference != nil)
              choose(factory_translate(user.contact_preference), name: 'respondents_detail[contact_preference]')
              if t(user.contact_preference) == t('questions.contact_preference.email.label')
                preference_email.set(user.email_address)
              end
              if t(user.contact_preference) == t('questions.contact_preference.post.label')
                preference_email.set(user.post)
              end
              if t(user.contact_preference) == t('questions.contact_preference.fax.label')
                preference_fax.set(user.fax_number)
              end
            end
          end
        end
        # Does this organisation have more than one site in Great Britain?
        section :organisation_employ_gb_question, :question_labelled, 'questions.organisation_employ_gb.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.respondents_details.employed_elswhere_blank', exact: false
          element :error_not_a_number, :exact_error_text, 'errors.respondents_details.not_a_number', exact: false
          def set(*args); field.set(*args); end
        end
        # How many people does this organisation employ in Great Britain? (optional)
        # For example, 10
        section :organisation_more_than_one_site_question, :single_choice_option, 'questions.organisation_more_than_one_site.label', exact: false do |q|
          include EtFullSystem::Test::I18n
          element :inclusion, :exact_error_text, 'errors.respondents_details.employed_elswhere_blank', exact: false
          section :yes, :gds_multiple_choice_option, 'questions.organisation_more_than_one_site.yes.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.organisation_more_than_one_site.no.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          # How many people are employed at the place where the claimant worked?
          # For example, 10
          section :employment_at_site_number, :inputtext_labelled, 'questions.organisation_more_than_one_site.employment_at_site_number.label', exact: false do
            element :employment_at_site_number_hint, :form_hint, 'questions.organisation_more_than_one_site.employment_at_site_number.hint'
            def set(*args); root_element.set(*args); end
          end
          element :error_not_a_number, :exact_error_text, 'errors.respondents_details.not_a_number', exact: false
          def set_for(user)
            choose(factory_translate(user.organisation_more_than_one_site), name: 'respondents_detail[organisation_more_than_one_site]')
            if t(user.organisation_more_than_one_site) == t('questions.organisation_more_than_one_site.yes.label')
              employment_at_site_number.set(user.employment_at_site_number)
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

        def has_correct_translation?
          # Respondent's Details
          expect(self).to have_header
          # Case number
          expect(self).to have_case_number_question
          # Name of individual, company or organisation
          expect(self).to have_name_question
          # Name of contact (optional)
          expect(self).to have_contact_question
          expect(contact_question).to have_contact_hint
          # Building name or number
          expect(self).to have_building_name_question
          # Street
          expect(self).to have_street_question
          # Town/City
          expect(self).to have_town_question
          # County (optional)
          expect(self).to have_county_question
          # Postcode
          expect(self).to have_postcode_question
          # Document exchange (DX) number (optional)
          expect(self).to have_dx_number_question
          # Contact number (optional)
          expect(self).to have_contact_number_question
          # Mobile number (optional)
          expect(self).to have_contact_mobile_number_question
          expect(contact_mobile_number_question).to have_mobile_hint
          # How would you prefer us to contact you? (optional)
          expect(self).to have_contact_preference_question
          expect(contact_preference_question).to have_select_email
          expect(contact_preference_question).to have_select_post
          expect(contact_preference_question).to have_select_fax
          # Does this organisation have more than one site in Great Britain?
          expect(self).to have_organisation_employ_gb_question
        end

        def has_correct_blank_error_messages?
          expect(self).to have_error_header
          expect(case_number_question).to have_error_invalid
          expect(name_question).to have_error_blank
          expect(building_name_question).to have_error_blank
          expect(street_question).to have_error_blank
          expect(town_question).to have_error_blank
          expect(postcode_question).to have_error_blank
          expect(organisation_more_than_one_site_question).to have_inclusion
        end
      end
    end
  end
end
