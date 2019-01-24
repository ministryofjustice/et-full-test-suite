Capybara.add_selector(:remove_multiple) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.remove-multiple')[x.string.n.is(translated)] }
  end
end