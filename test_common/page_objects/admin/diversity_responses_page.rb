module EtFullSystem
  module Test
    module Admin
      class DiversityResponsesPage < Admin::BasePage
        set_url "/diversity_responses"

        def has_response_for?(data)
          api = EtFullSystem::Test::AdminApi.new
          expected_data = data.to_h.inject({}) do |acc, (k,v)|
            acc[k] = factory_translate(v)
            acc
          end
          expect {api.admin_diversity_data.symbolize_keys}.to eventually include(expected_data), timeout: 30, sleep: 2
          true
        end
      end
    end
  end
end
