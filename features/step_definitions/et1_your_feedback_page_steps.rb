Given("a claimant is on the Your feedback page") do
  load_et1_start_page
  et1_apply_page.feedback_notice.feedback_link.click
  expect(et1_your_feedback_page.header.text).to be_truthy
end

Then("Your feedback page copy texts are displayed in the correct language") do
  expect(et1_your_feedback_page.has_correct_translation?).to be true
end

When("I submit Your feedback") do
  et1_submit_your_feedback
end

Then("I should see thank you for your feedback message") do
  expect(et1_your_feedback_page.flash_heading.flash_message).to be_truthy
end