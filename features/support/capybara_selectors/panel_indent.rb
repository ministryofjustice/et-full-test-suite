Capybara.add_selector(:panel_indent) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:div)[x.string.n.is(translated)] }
  end
end