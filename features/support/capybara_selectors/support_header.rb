Capybara.add_selector(:support_header) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:h3)[x.string.n.is(translated)] }
  end
end
