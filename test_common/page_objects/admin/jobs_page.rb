module EtFullSystem
  module Test
    module Admin
      class JobsPage < Admin::BasePage
        set_url "/jobs"

        element :sidekiq_iframe, '.active-admin-sidekiq iframe'

        def within_sidekiq_iframe(&block)
          within_frame(sidekiq_iframe, &block)
        end

        def run_export_claims_cron_job
          load
          within_sidekiq_iframe do
            Admin::JobSidekiqCronPage.new.run_export_claims_cron_job
          end

        end
      end
    end
  end
end