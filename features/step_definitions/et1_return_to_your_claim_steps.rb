Given("a claimant is on the Return to your claim page") do
  load_et1_start_page
  et1_apply_page.return_to_claim
end

Then("Return to your claim copy texts are displayed in the correct language") do
  expect(et1_return_to_your_claim_page.has_correct_translation?).to be true
end

Given("I'm a return claimant") do
  start_a_new_et1_claim
  claim_number = et1_application_number_page.main_content.claims_number.text
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, claim_number: claim_number)
  et1_answer_login
  @page_left_off = current_url
  page.reset!
  load_et1_start_page
  et1_apply_page.return_to_claim
end

When("I enter my claim details") do
  et1_return_to_your_claim_page.set(@claimant)
  et1_return_to_your_claim_page.find_my_claim
end

Then("I should be taken to where I was left off") do
  expect(current_url).to eq( @page_left_off)
end

When("I click Start a new claim") do
  et1_return_to_your_claim_page.start_a_new_claim
end

Then("I should be taken to Start a new claim page") do
  expect(et1_apply_page.header.text).to be_truthy
end