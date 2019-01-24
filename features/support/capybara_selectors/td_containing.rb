Capybara.add_selector(:td_containing) do
  xpath do |locator, _options|
    translated = EtFullSystem::Test::Messaging.instance.translate(locator)
    XPath.generate do |x|
      x.descendant(:td)[x.string.n.equals(translated)]
    end
  end
end
