require 'rspec/matchers'
RSpec::Matchers.define :eventually do |matcher, timeout: 5, sleep: 0.1|
  supports_block_expectations
  attempts = 0
  match do |actual|
    begin
      Timeout.timeout(timeout) do
        attempts += 1 && sleep(sleep) until matcher.matches?(actual.call)
        return true
      end
    rescue Timeout::Error
      return false
    end
  end

  failure_message do |_actual|
    matcher.failure_message + " (after trying #{attempts} times, gave up after #{timeout} seconds)"
  end
end
