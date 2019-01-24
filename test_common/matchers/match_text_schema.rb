def match_text_schema(expected)
  EtFullSystem::Test::MatchTextSchema.new(expected)
end

module EtFullSystem
  module Test
    class MatchTextSchema
      def initialize(expected)
        self.expected = expected
        self.mismatches = []
      end

      def matches?(actual)
        self.mismatches = []
        self.actual_values = actual_as_array(actual)
        expected.each_with_index do |specification, idx|
          matcher = matcher_for(specification)
          unless matcher.matches?(actual_values[idx])
            mismatches << "Line #{idx + 1} - #{matcher.failure_message}"
          end
        end
        mismatches.empty?
      end

      def failure_message
        "The data provided did not match the schema - here are the details: \n\n#{mismatches.join("\n")}"
      end

      private

      def actual_as_array(actual)
        case actual
        when String then actual.lines("\r\n").map {|l| l.gsub(/\r\n\z/, '')}
        when IO then actual.read.lines("\r\n").map {|l| l.gsub(/\r\n\z/, '')}
        else raise "Must be a string or a file containing the data to be read"
        end
      end

      def matcher_for(specification)
        case specification
        when String then ::RSpec::Matchers::BuiltIn::Eq.new(specification)
        else specification
        end
      end

      attr_accessor :expected, :mismatches, :actual_values
    end
  end
end
