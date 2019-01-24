Capybara.add_selector(:listing_containing_text) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:li)[x.string.n.is(translated)] }
  end
end
