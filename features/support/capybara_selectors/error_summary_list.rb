Capybara.add_selector(:error_summary_list) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css('.error-summary-list')[x.string.n.is(translated)] }
  end
end