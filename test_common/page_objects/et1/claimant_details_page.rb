require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimantDetailsPage < BasePage
        include RSpec::Matchers
        #page and main header
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.claimant.header', exact: false
        end
        section :main_content, '.main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end
          #About the claimant
          element :legend_personal_details, :legend_header, 'claims.claimant.legend_personal_details', exact: false
          #information about the person
          element :personal_details_description, :paragraph, 'claims.claimant.personal_details_description', exact: false
          #title
          section :title, :question_labelled, 'simple_form.labels.claimant.title' do
            include EtFullSystem::Test::I18n
            def set(value)
              root_element.select(factory_translate value)
            end
            element :error_title, :error, 'activemodel.errors.models.claimant.attributes.title.blank', exact: false
          end
          #first name
          section :first_name, :question_labelled, 'simple_form.labels.claimant.first_name' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
            element :error_first_name, :error, 'activemodel.errors.models.claimant.attributes.first_name.blank'
          end
          #lastname name
          section :last_name, :question_labelled, 'simple_form.labels.claimant.last_name' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
            element :error_last_name, :error, 'activemodel.errors.models.claimant.attributes.last_name.blank'
          end
          #Date of birth
          section :date_of_birth, :legend_header, 'claims.personal_details.date_of_birth', exact: false do
            element :error_date_of_birth, :error, 'activemodel.errors.models.claimant.attributes.date_of_birth.too_young'
            element :invalid_date_of_birth, :error, 'activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.date_of_birth.invalid'
            element :date_of_birth_hint, :paragraph, 'simple_form.hints.claimant.date_of_birth'
            section :day, :question_labelled, 'simple_form.labels.claimant.date_of_birth.day' do
              element :field, :css, '#claimant_date_of_birth_day'
              def set(*args); field.set(*args); end
            end
            section :month, :question_labelled, 'simple_form.labels.claimant.date_of_birth.month' do
              element :field, :css, '#claimant_date_of_birth_month'
              def set(*args); field.set(*args); end
            end
            section :year, :question_labelled, 'simple_form.labels.claimant.date_of_birth.year' do
              element :field, :css, '#claimant_date_of_birth_year'
              def set(*args); field.set(*args); end
            end
            def set(value)
              (day_value, month_value, year_value) = value.split("/")
              day.set(day_value)
              month.set(month_value)
              year.set(year_value)
            end
          end
          section :gender, :question_labelled, 'claims.claimant.gender' do
            include ::EtFullSystem::Test::I18n
            element :error_gender, :error, 'activemodel.errors.models.claimant.attributes.gender.blank'
            element :male, :form_labelled, 'simple_form.options.claimant.gender.male' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :female, :form_labelled, 'simple_form.options.claimant.gender.female' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :prefer_not_to_say, :form_labelled, 'simple_form.options.claimant.gender.prefer_not_to_say' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'claimant[gender]')
            end
          end
          #has special needs
          section :claimant_has_special_needs, '.form-group-reveal' do
            include ::EtFullSystem::Test::I18n
            element :has_special_needs, :form_labelled, 'simple_form.labels.claimant.has_special_needs'
            element :has_special_needs_hint, :paragraph, 'simple_form.hints.claimant.has_special_needs'
            element :yes, :form_labelled, 'simple_form.yes' do
              element :selector, :css, '#claimant_has_special_needs_true'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'simple_form.no' do
              element :selector, :css, '#claimant_has_special_needs_false'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'claimant[has_special_needs]')
            end
          end
          #describe the assistance you require
          section :assistance, '.claimant_special_needs' do
            element :special_needs, :textarea_labelled, 'simple_form.labels.claimant.special_needs'
            element :field, :css, 'textarea'
            def set(*args); field.set(*args); end
          end
          #Claimant's contact details
          element :claimants_contact_details, :legend_header, 'claims.claimant.legend_contact_details', exact: false
          section :building, :question_labelled, 'simple_form.labels.claimant.address_building' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :error_building, :error, 'activemodel.errors.models.claimant.attributes.address_building.blank'
          section :street, :question_labelled, 'simple_form.labels.claimant.address_street' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :error_street, :error, 'activemodel.errors.models.claimant.attributes.address_street.blank'
          section :locality, :question_labelled, 'simple_form.labels.claimant.address_locality' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :error_locality, :error, 'activemodel.errors.models.claimant.attributes.address_locality.blank'
          #County
          section :county, :question_labelled, 'simple_form.labels.claimant.address_county' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :error_county, :error, 'activemodel.errors.models.claimant.attributes.address_county.blank'
          element :county_hint, :paragraph, 'simple_form.hints.claimant.address_county', exact: false
          section :post_code, :question_labelled, 'simple_form.labels.claimant.address_post_code' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :blank_post_code, :error, 'activemodel.errors.models.claimant.attributes.address_post_code.blank'
          element :invalid_post_code, :error, 'activemodel.errors.models.claimant.attributes.address_post_code.invalid'
          section :country, :question_labelled, 'simple_form.labels.claimant.address_country' do
            include ::EtFullSystem::Test::I18n
            def set(value)
              root_element.select(factory_translate(value))
            end
          end
          element :error_address_county, :error, 'activemodel.errors.models.claimant.attributes.address_county.blank'
          section :telephone_number, :question_labelled, 'simple_form.labels.claimant.address_telephone_number' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          section :alternative_telephone_number, :question_labelled, 'simple_form.labels.claimant.mobile_number' do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          section :email_address, :question_labelled, 'simple_form.labels.claimant.email_address', exact: false do
            element :invalid_email_address, :error, 'activemodel.errors.models.claimant.attributes.email_address.invalid'
            element :field, :css, 'input[type="email"]'
            def set(*args); field.set(*args); end
          end
          element :blank_email_address, :error, 'activemodel.errors.models.claimant.attributes.email_address.blank'
          #correspondence
          section :claimant_contact_preference, '.claimant_contact_preference' do
            include ::EtFullSystem::Test::I18n
            element :error_claimant_contact_preference, :error, 'activemodel.errors.models.claimant.attributes.contact_preference.blank'
            element :correspondence, :form_labelled, 'simple_form.labels.claimant.contact_preference'
            element :contact_preference, :paragraph, 'simple_form.hints.claimant.contact_preference', exact: false
            section :email_preference, :form_labelled, 'simple_form.options.claimant.contact_preference.email' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            section :post_preference, :form_labelled, 'simple_form.options.claimant.contact_preference.post' do 
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'claimant[contact_preference]')
            end
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

        def has_correct_translation?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Page header
          expect(main_header).to have_page_header
          #About your claimant
          expect(main_content).to have_legend_personal_details
          expect(main_content).to have_personal_details_description
          expect(main_content).to have_title
          expect(main_content).to have_first_name
          expect(main_content).to have_last_name
          #date of birth
          expect(main_content).to have_date_of_birth
          expect(main_content.date_of_birth).to have_date_of_birth_hint
          expect(main_content.date_of_birth).to have_day
          expect(main_content.date_of_birth).to have_month
          expect(main_content.date_of_birth).to have_year
          #gender
          expect(main_content).to have_gender
          expect(main_content.gender).to have_male
          expect(main_content.gender).to have_female
          expect(main_content.gender).to have_prefer_not_to_say
          #has special needs
          expect(main_content.claimant_has_special_needs).to have_has_special_needs
          expect(main_content.claimant_has_special_needs).to have_has_special_needs_hint
          expect(main_content.claimant_has_special_needs).to have_yes
          expect(main_content.claimant_has_special_needs).to have_no
          expect(main_content.assistance).to have_special_needs
          #Claimant's contact details
          expect(main_content).to have_claimants_contact_details
          expect(main_content).to have_building
          expect(main_content).to have_street
          expect(main_content).to have_locality
          expect(main_content).to have_county
          expect(main_content).to have_county_hint
          expect(main_content).to have_post_code
          expect(main_content).to have_country
          expect(main_content).to have_telephone_number
          expect(main_content).to have_alternative_telephone_number
          expect(main_content).to have_email_address
          #Best way to send correspondence
          expect(main_content.claimant_contact_preference).to have_correspondence
          expect(main_content.claimant_contact_preference).to have_contact_preference
          expect(main_content.claimant_contact_preference).to have_email_preference
          expect(main_content.claimant_contact_preference).to have_post_preference
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
        
        def has_correct_translation_for_assistance_required?
          expect(main_content.assistance).to have_special_needs
        end

        def has_correct_error_message_for_leaving_email_address_field_blank?
          expect(main_content).to have_blank_email_address
        end

        def has_correct_error_message_for_invalid_email_address?
          expect(main_content.email_address).to have_invalid_email_address
        end

        def has_correct_error_message_for_invalid_uk_postcode?
          expect(main_content).to have_invalid_post_code
        end

        def has_correct_invalid_error_message_for_dob?
          expect(main_content.date_of_birth).to have_invalid_date_of_birth
        end

        def has_correct_validation_error_message?
          #Errors on page
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.title).to have_error_title
          expect(main_content.first_name).to have_error_first_name
          expect(main_content.last_name).to have_error_last_name
          expect(main_content.date_of_birth).to have_error_date_of_birth
          expect(main_content.gender).to have_error_gender
          expect(main_content).to have_error_building
          expect(main_content).to have_error_street
          expect(main_content).to have_error_locality
          expect(main_content).to have_error_county
          expect(main_content).to have_blank_post_code
          expect(main_content).to have_error_address_county
          expect(main_content.claimant_contact_preference).to have_error_claimant_contact_preference
        end

        # Fills in the entire page for the user given
        #
        # @param [Hash] user The user hash
        def set(user)
          data = user[0].to_h
          main_content.tap do |s|
            set_field(s, :title, data)
            set_field(s, :first_name, data)
            set_field(s, :last_name, data)
            set_field(s, :date_of_birth, data)
            set_field(s, :gender, data)
          end

          main_content.claimant_has_special_needs.set(data[:has_special_needs])
          main_content.assistance.special_needs.set(data[:special_needs])
          main_content.claimant_contact_preference.set(data[:claimant_contact_preference])

          main_content.tap do |s|
            set_field(s, :building, data)
            set_field(s, :street, data)
            set_field(s, :locality, data)
            set_field(s, :county, data)
            set_field(s, :post_code, data)
            set_field(s, :country, data)
            set_field(s, :telephone_number, data)
            set_field(s, :alternative_telephone_number, data)
            set_field(s, :email_address, data)
            set_field(s, :claimant_contact_preference, data)
          end
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        private
        
        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
