Capybara.add_selector(:diversity_input_button_named) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.css("input[value='#{translated}']") }
  end
end
