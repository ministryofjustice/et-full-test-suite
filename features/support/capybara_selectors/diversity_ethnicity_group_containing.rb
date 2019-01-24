Capybara.add_selector(:diversity_ethnicity_group_containing) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:fieldset)[x.descendant(:label)[x.string.n.is(translated)]] }
  end
end
