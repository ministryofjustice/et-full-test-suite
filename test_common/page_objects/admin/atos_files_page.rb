module EtFullSystem
  module Test
    module Admin
      class AtosFilesPage < Admin::BasePage
        set_url "/atos_files"

        elements :files, :css, 'td'

        def file_count
          files.length
        end
      end
    end
  end
end