module EtFullSystem
  module Test
    module Admin
      class JobSidekiqCronPage < Admin::BasePage
        set_url '/sidekiq/cron'
        cron_jobs_xpath = XPath.generate do |x|
          x.descendant(:div)[x.child(:header)[x.descendant(:h3)[x.string.n.is('Cron Jobs')]]]
        end

        section :jobs, :xpath, cron_jobs_xpath do
          section :export_claims, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:td)[x.child(:b)[x.string.n.is('export_claims_job')]]]} do
            element :enqueue_button, :css, 'input[value="Enqueue Now"]'
            def run
              enqueue_button.click
            end
          end
        end

        def run_export_claims_cron_job
          load
          jobs.export_claims.run
        end
      end
    end
  end
end