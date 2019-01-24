require_relative '../messaging'
require 'rspec/matchers'
module EtFullSystem
  module Test
    # @private
    class BaseSection < SitePrism::Section
      include RSpec::Matchers
      include EtFullSystem::Test::I18n

    end
  end
end
