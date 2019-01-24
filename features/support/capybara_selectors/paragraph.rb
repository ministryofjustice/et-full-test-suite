Capybara.add_selector(:paragraph) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:p)[x.string.n.is(translated)] }
  end
end
