Given("a claimant is on Claimant's details page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  start_a_new_et1_claim
  et1_answer_login
end

Then("Claimant's details page copy texts are displayed in the correct language") do
  expect(et1_claimant_details_page.has_correct_translation?).to be true
end

When("I answerd Yes to disability") do
  et1_claimant_details_page.main_content.claimant_has_special_needs.set(@claimant[0][:has_special_needs])
  et1_claimant_details_page.main_content.assistance.special_needs.set(@claimant[0][:special_needs])
end

Then("I should see the option to describe the assistant I need") do
  expect(et1_claimant_details_page.has_correct_translation_for_assistance_required?).to be true
end

Then("I should be able to select Outside United Kingdom as country of residence") do
  claimant = FactoryBot.create_list(:claimant, 1, :person_data, country: :"simple_form.options.claimant.address_country.other")
  et1_claimant_details_page.main_content.country.set(claimant[0][:country])
end

When("I submit without answering any questions") do
  et1_claimant_details_page.save_and_continue.click
end

Then("I should see mandatory errors on the Claimant's details page") do
  expect(et1_claimant_details_page.has_correct_validation_error_message?).to be true
end

When("leaving an email address field blank") do
  et1_claimant_details_page.main_content.claimant_contact_preference.set(@claimant[0][:correspondence])
  et1_claimant_details_page.save_and_continue.click
end

Then("I should see an error message for leaving email address field blank") do
  expect(et1_claimant_details_page.has_correct_error_message_for_leaving_email_address_field_blank?).to be true
end

When("entering an invalid email address") do
  et1_claimant_details_page.main_content.email_address.set('blah@blah')
  et1_claimant_details_page.save_and_continue.click
end

Then("I should see an error message for entering invalid email address") do
  expect(et1_claimant_details_page.has_correct_error_message_for_invalid_email_address?).to be true
end

When("entering {string} postcode") do |string|
  et1_claimant_details_page.main_content.post_code.set(string)
  et1_claimant_details_page.save_and_continue.click
end

Then("I should see an error message for invalid UK postcode please use SW55 9QT") do
  expect(et1_claimant_details_page.has_correct_error_message_for_invalid_uk_postcode?).to be true
end

When("I submit an invalid date of birth for claimant details page") do
  et1_claimant_details_page.main_content.date_of_birth.set('0/0/01')
  et1_claimant_details_page.save_and_continue.click
end

Then("I should see an invalid error message for date of birth claimant details page") do
  expect(et1_claimant_details_page.has_correct_invalid_error_message_for_dob?).to be true
end