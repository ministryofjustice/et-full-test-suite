require 'settingslogic'

module EtFullSystem
  module Test
    class Configuration < Settingslogic
      source File.join(File.dirname(__FILE__), '../config/environment_config.yml')
      namespace ENV['ENVIRONMENT'] ||= 'local'
    end
  end
end
