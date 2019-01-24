require_relative '../../../test_common/helpers/upload_helper'
module EtFullSystem
  module Test
    module Admin
      class ImportFilePage < Admin::BasePage
        include ::EtFullSystem::Test::UploadHelper
        section :main_content, '#main_content #new_admin_users_import_service' do
          element :choose_file, 'fieldset.inputs #admin_users_import_service_file'
          element :import_button, 'fieldset.actions input[type=submit]'
        end

        def choose_file(users)
          users_csv = users.dig(:users_file)
          force_remote do
            full_path = File.expand_path(File.join('test_common', 'fixtures', users_csv))
            main_content.choose_file.set(full_path)
          end
          import_button
        end

        def import_button
          main_content.import_button.click
        end
      end
    end
  end
end
