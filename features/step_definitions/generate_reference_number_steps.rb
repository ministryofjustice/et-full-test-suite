Given("load Generate Reference page") do
  admin_pages.any_page.menu.click_generate_references
end

When("I enter a postcode {string}") do |string|
  admin_pages.generate_reference_number_page.generate_reference(string)
end

Then("a random reference number is displayed {string}") do |string|
  expect(admin_pages.generate_reference_result_page.main_content.search_result.text).to include(string)
end

Then("an error message is displayed {string}") do |string|
  expect(admin_pages.generate_reference_number_page.error_message.text).to have_content(string) 
end