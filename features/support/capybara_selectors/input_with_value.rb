Capybara.add_selector(:input_with_value) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate { |x| x.descendant(:input)[x.attr(:value).normalize.equals(translated)] }
  end
end
