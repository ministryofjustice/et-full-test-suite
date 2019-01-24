require_relative '../../test_common/configuration'
require_relative '../../test_common/capybara'
require_relative '../../test_common/page_objects'
require_relative '../../test_common/file_objects'
require_relative '../../test_common/messaging'
require_relative '../../test_common/helpers'
require_relative '../../test_common/common_admin_window'
require_relative '../../test_common/atos_interface'
require_relative '../../test_common/rspec_eventually'
require_relative '../../test_common/housekeeping'
require_relative '../../test_common/matchers'
require_relative '../../test_common/api/admin'
include EtFullSystem::Test::Pages
include EtFullSystem::Test::Et1ClaimHelper
include EtFullSystem::Test::Et3ResponseHelper
include EtFullSystem::Test::DiversityHelper
include EtFullSystem::Test::CommonAdminWindow
include EtFullSystem::Test::AtosInterfaceHelper
include EtFullSystem::Test::Housekeeping
include EtFullSystem::Test::Et1Export
include EtFullSystem::Test::Et3Export
Before do
  EtFullSystem::Test::CommonAdminWindow.reset
end
After do
  EtFullSystem::Test::CommonAdminWindow.ensure_admin_window_closed
end
