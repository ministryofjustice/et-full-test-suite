Capybara.add_selector(:exact_error_text) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:span)[x.string.n.is(translated)]["contains(concat(' ',normalize-space(@class),' '),' error-message ')"] }
  end
end
