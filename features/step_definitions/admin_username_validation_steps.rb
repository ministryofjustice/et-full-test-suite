Then(/^add a new user$/) do
  admin_pages.any_page.menu.click_users
  admin_pages.users_page.click_new_user
end

When("I enter {string} characters in the username field") do |string|
  admin_pages.new_user_page.username.set(string)
  admin_pages.new_user_page.create_user_button.click
end

Then("the following error message is shown {string}") do |string|
  expect(admin_pages.new_user_page.username_error.text).to have_content(string)
end