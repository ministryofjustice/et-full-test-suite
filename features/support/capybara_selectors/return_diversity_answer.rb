Capybara.add_selector(:return_diversity_answer) do
  xpath do |_locator, _options|
    XPath.generate { |x| x.descendant(:td)[1] }
  end
end
