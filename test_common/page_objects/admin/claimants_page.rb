module EtFullSystem
  module Test
    module Admin
      class ClaimantsPage < Admin::BasePage
        set_url "/claimants"
        section :main_table, '#index_table_claimants tbody tr' do
          element :first_name, 'td.col.col-first_name'
        end
      end
    end
  end
end