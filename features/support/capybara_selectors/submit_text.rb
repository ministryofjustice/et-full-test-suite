Capybara.add_selector(:submit_text) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css("input[name=\"commit\"][value=\"#{translated}\"]")}
  end
end