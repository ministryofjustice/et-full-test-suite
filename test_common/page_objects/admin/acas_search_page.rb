module EtFullSystem
  module Test
    module Admin
      class AcasSearchPage < Admin::BasePage
        section :search_fieldset, :fieldset, 'ACAS Search' do
          element :search_field, :fillable_field, 'Please enter your ACAS Early Conciliation Certificate number*'
        end

        element :search_button, 'fieldset.actions input[value=Search]'

        def search(value)
          search_fieldset.search_field.set(value)
          search_button.click
        end
      end
    end
  end
end
