module EtFullSystem
  module Test
    module Admin
      class GenerateReferenceResultPage < Admin::BasePage
        section :main_content, '#main_content' do
          element :search_result, 'h1'
        end
      end
    end
  end
end
