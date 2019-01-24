require_relative './test_common'
require 'capybara-screenshot/cucumber'

module Capybara
  module Screenshot
    class S3Saver
      def output_screenshot_path
        if html_saved?
          unsigned_url = html_path
          key = unsigned_url.split('/').last
          signer = Aws::S3::Presigner.new client: s3_client
          url = signer.presigned_url(:get_object, bucket: bucket_name, key: key, expires_in: 14400)
          output "HTML screenshot: #{url}"
        end

        if screenshot_saved?
          unsigned_url = screenshot_path
          key = unsigned_url.split('/').last
          signer = Aws::S3::Presigner.new client: s3_client
          url = signer.presigned_url(:get_object, bucket: bucket_name, key: key, expires_in: 14400)
          output "Image screenshot: #{url}"
        end
      end
    end
  end
end


After do |scenario|
  if Capybara::Screenshot.autosave_on_failure && scenario.failed?
    Capybara.using_session(Capybara::Screenshot.final_session_name) do
      filename_prefix = Capybara::Screenshot.filename_prefix_for(:cucumber, scenario) + "_admin"
      next unless EtFullSystem::Test::CommonAdminWindow.admin_window_opened?
      within_admin_window do
        saver = Capybara::Screenshot.new_saver(Capybara, Capybara.page, true, filename_prefix)
        saver.save
        saver.output_screenshot_path
      end
    end
  end
end
