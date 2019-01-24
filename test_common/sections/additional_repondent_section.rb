module EtFullSystem
  module Test
    class AdditionalRespondentSection < BaseSection
      #Respondent 2
      element :blank_name, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.name.blank'
      section :name, :question_labelled, 'simple_form.labels.respondent.name' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :blank_building, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_building.blank'
      section :building, :question_labelled, 'simple_form.labels.respondent.address_building' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :blank_street, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_building.blank'
      section :street, :question_labelled, 'simple_form.labels.respondent.address_street' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :blank_locality, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_street.blank'
      section :locality, :question_labelled, 'simple_form.labels.respondent.address_locality' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :blank_county, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_locality.blank'
      element :county_hint, :paragraph, 'simple_form.hints.respondent.address_county', exact: false
      section :county, :question_labelled, 'simple_form.labels.respondent.address_county' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :blank_post_code, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_post_code.blank'
      element :invalid_post_code, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.address_post_code.invalid'
      section :post_code, :question_labelled, 'simple_form.labels.respondent.address_post_code' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      #Acas number
      element :invalid_acas_number, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.acas_early_conciliation_certificate_number.invalid'
      element :blank_acas_number, :error, 'activemodel.errors.models.additional_respondents_form/additional_respondent.attributes.acas_early_conciliation_certificate_number.blank'
      section :acas_number, :question_labelled, 'simple_form.labels.respondent.acas_early_conciliation_certificate_number' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      #I don't have an Acas number
      element :no_acas_number, :form_labelled, 'simple_form.labels.respondent.no_acas_number' do
        element :field, :css, 'input'
        def set(*args); field.set(*args); end
      end
      element :no_acas_number_note_one, :form_hint, 'claims.respondent.no_acas_number_note_one', exact: false
      section :respondent_no_acas_number_reason, '.additional_respondents_collection_no_acas_number_reason' do
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
          choose(factory_translate(value), name: 'additional_respondents[collection_attributes][0][no_acas_number_reason]')
        end
      end
    end
  end
end
