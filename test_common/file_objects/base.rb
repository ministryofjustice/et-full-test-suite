module EtFullSystem
  module Test
    module FileObjects
      class Base
        def initialize(tempfile)
          self.tempfile = tempfile
        end

        private

        attr_accessor :tempfile

      end
    end
  end
end
