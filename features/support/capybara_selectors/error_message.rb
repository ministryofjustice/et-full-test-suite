Capybara.add_selector(:error_message) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.error-message')[x.string.n.is(translated)] }
  end
end