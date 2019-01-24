Given("a claimant is on the Apply page") do
  load_et1_start_page
end

Then("Apply page copy texts are displayed in the correct language") do
  expect(et1_apply_page.has_correct_translation?).to be true
end

When("user click on Your feedback link") do
  et1_apply_page.feedback_notice.feedback_link.click
end

Then("user is taken to the feedback page") do
  expect(et1_your_feedback_page.header.text).to be_truthy
end

When("user click on Learn about when you can apply link") do
  et1_apply_page.learn_how_to_apply
end

Then("user is taken to the time limits page") do
  expect(et1_guide_page.has_correct_translation_for_time_limits?).to be true
end

When("user click on Acas early conciliation certificate number") do
  et1_apply_page.acas_certificate_number
end

Then("user is taken to the Acas early conciliation page") do
  expect(et1_guide_page.has_correct_translation_for_acas_early_conciliation?).to be true
end