require 'capybara-screenshot'
module EtFullSystem
  module Test
    module FullScreenshot
      def self.with_resizing
        changed = false
        orig_size = Capybara.current_session.current_window.size
        begin
          width, height = page_size
          Capybara.current_session.current_window.resize_to(width + 100, height + 100)
          changed = true
          yield
        ensure
          Capybara.current_session.current_window.resize_to(*orig_size) if changed
        end
      end

      def self.page_size
        width  = Capybara.page.execute_script("return Math.max(document.body.scrollWidth, document.body.offsetWidth, document.documentElement.clientWidth, document.documentElement.scrollWidth, document.documentElement.offsetWidth);")
        height = Capybara.page.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")
        [width, height]
      end
    end
  end
end
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  ::EtFullSystem::Test::FullScreenshot.with_resizing do
    driver.browser.save_screenshot(path)
  end
end
Capybara::Screenshot.register_driver(:chromedriver) do |driver, path|
  ::EtFullSystem::Test::FullScreenshot.with_resizing do
    driver.browser.save_screenshot(path)
  end
end
Capybara::Screenshot.register_driver(:firefoxdriver) do |driver, path|
  ::EtFullSystem::Test::FullScreenshot.with_resizing do
    driver.browser.save_screenshot(path)
  end
end
if ENV.key?('SCREENSHOT_S3_ACCESS_KEY_ID')
  Capybara::Screenshot.prune_strategy = { keep: 20 }
  Capybara::Screenshot.s3_configuration = {
      s3_client_credentials: {
          access_key_id: ENV.fetch('SCREENSHOT_S3_ACCESS_KEY_ID'),
          secret_access_key: ENV.fetch('SCREENSHOT_S3_SECRET_ACCESS_KEY'),
          region: ENV.fetch('SCREENSHOT_S3_REGION'),
      },
      bucket_name: ENV.fetch('SCREENSHOT_S3_BUCKET'),
      key_prefix: ENV.fetch('SCREENSHOT_S3_KEY_PREFIX', '')
  }
end
