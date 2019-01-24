Capybara.add_selector(:diversity_hidden_input) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:div)[x.child(:p)[x.string.n.is(translated)]] }
  end
end
