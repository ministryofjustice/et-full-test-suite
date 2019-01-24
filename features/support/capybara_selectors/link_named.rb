Capybara.add_selector(:link_named) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:a)[x.string.n.is(translated)] }
  end
end
