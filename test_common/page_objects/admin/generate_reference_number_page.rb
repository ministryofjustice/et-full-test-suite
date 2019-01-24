module EtFullSystem
  module Test
    module Admin
      class GenerateReferenceNumberPage < Admin::BasePage
        element :error_message, '.flash.flash_warn'
        section :main_content, '#main_content #new_admin_generate_reference' do
          element :search_field, :fillable_field, "Claimant's Workplace Postcode"
          element :submit, 'input[type="submit"]' 
        end

        def generate_reference(postcode)
          main_content.search_field.set(postcode)
          main_content.submit.click
        end
      end
    end
  end
end
