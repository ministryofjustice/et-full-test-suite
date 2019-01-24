# TODO: Refactor so as not to use CSS selectors
require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class FormSubmissionPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        element :header, :main_header, 'submission.confirmation'
        element :submission_confirmation, :element_with_text, 'submission.confirmation'
        element :reference_number, :css, '.bold.reference-number'
        element :thank_you, :element_with_text, 'submission.thank_you'
        element :local_office_address, :css, '.office-address'
        element :local_office_phone, :css, '.office-phone'
        element :submission_date, :css, '.submission-date'
        element :valid_pdf_download, :link_named, 'links.form_submission.valid_pdf_download'
        element :invalid_pdf_download, :link_named, 'links.form_submission.invalid_pdf_download'
        element :return_to_govuk_button, :link_named, 'submission.return_link'
        def return
          return_to_govuk_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end
  
        def switch_to_english
          switch_language.english_link.click
        end
      end
    end
  end
end
