Capybara.add_selector(:group_claimants) do
  xpath do |locator, number:, **_options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator, number: number)
    XPath.generate { |x| x.descendant(:fieldset)[x.child(:legend)[x.string.n.is(translated)]] }
  end
  expression_filter(:number) { |xpath, _val| xpath }
end
