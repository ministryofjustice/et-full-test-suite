Capybara.add_selector(:table_row_with_th_labelled) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:tr)[x.child(:th)[x.string.n.is(translated)]] }
  end
end
