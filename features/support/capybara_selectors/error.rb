Capybara.add_selector(:error) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.error')[x.string.n.is(translated)] }
  end
end