Capybara.add_selector(:gds_multiple_choice_option) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.multiple-choice')[x.descendant(:label)[x.string.n.is(translated)]] }
  end
end
