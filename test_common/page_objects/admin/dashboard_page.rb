module EtFullSystem
  module Test
    module Admin
      class DashboardPage < Admin::BasePage
        set_url ""

        def admin_login(username, password)
          admin_pages.logout_page.load
          if admin_pages.login_page.displayed?
            admin_pages.login_page.login(username: username, password: password)
            raise "Could not login to admin with username '#{username}' and password '#{password}'" unless admin_pages.dashboard_page.displayed?
          end
        end
      end
    end
  end
end