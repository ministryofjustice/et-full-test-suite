module EtFullSystem
  module Test
    # A single admin window for use by all tests
    module CommonAdminWindow
      WINDOW_VAR_NAME = :et_full_system_test_admin_window

      def admin_username
        ::EtFullSystem::Test::Configuration.admin_username
      end

      def admin_password
        ::EtFullSystem::Test::Configuration.admin_password
      end

      def within_admin_window(&block)
        within_window(admin_window, &block)
      end

      def reset
        Thread.current[WINDOW_VAR_NAME] = nil
      end

      def admin_window
        return Thread.current[WINDOW_VAR_NAME] if Thread.current.key?(WINDOW_VAR_NAME)
        window = open_new_window
        Thread.current[WINDOW_VAR_NAME] = window
        start_admin_session(window)
        window
      end

      def start_admin_session(window)
        within_window(window) do
          admin_pages.dashboard_page.load
          if admin_pages.login_page.displayed?
            admin_pages.login_page.login(username: admin_username, password: admin_password)
            raise "Could not login to admin with username '#{admin_username}' and password '#{admin_password}'" unless admin_pages.dashboard_page.displayed?
          end
        end
        window
      end

      # The following self methods are to allow the 'after suite' hook or equivalent to close the admin window
      # as it doesn't have an example instance.
      def self.ensure_admin_window_closed
        close_admin_window if admin_window_opened?
      end

      def self.admin_window
        Thread.current[WINDOW_VAR_NAME]
      end

      def self.close_admin_window
        admin_window.close rescue nil
      end

      def self.admin_window_opened?
        Thread.current.key?(WINDOW_VAR_NAME)
      end
    end
  end
end
