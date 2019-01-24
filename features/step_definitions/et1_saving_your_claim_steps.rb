Given("a claimant is on Saving your claim page") do
  start_a_new_et1_claim
end

Then("Saving your claim copy texts are displayed in the correct language") do
  expect(et1_application_number_page.has_correct_translation?).to be true
end