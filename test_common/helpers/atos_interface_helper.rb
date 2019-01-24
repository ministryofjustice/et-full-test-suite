module EtFullSystem
  module Test
    module AtosInterfaceHelper
      def atos_interface
        thread = Thread.current
        thread[:atos_interface] ||= AtosInterface.new username: Configuration.atos_username,
                                                      password: Configuration.atos_password
      end
      def atos_secondary_interface
        thread = Thread.current
        thread[:atos_secondary_interface] ||= AtosInterface.new username: Configuration.atos_secondary_username,
                                                      password: Configuration.atos_secondary_password
      end
    end
  end
end
