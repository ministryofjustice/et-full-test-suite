require_relative 'test_common/configuration'
require_relative 'test_common/atos_interface.rb'
task :delete_zip_files_from_server do
  atos1 = EtFullSystem::Test::AtosInterface.new username: EtFullSystem::Test::Configuration.atos_username,
                                                password: EtFullSystem::Test::Configuration.atos_password
  atos2 = EtFullSystem::Test::AtosInterface.new username: EtFullSystem::Test::Configuration.atos_secondary_username,
                                                password: EtFullSystem::Test::Configuration.atos_secondary_password
  atos1.delete_zip_files
  atos2.delete_zip_files
end
