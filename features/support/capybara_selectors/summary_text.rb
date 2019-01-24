Capybara.add_selector(:summary_text) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.summary')[x.string.n.is(translated)] }
  end
end