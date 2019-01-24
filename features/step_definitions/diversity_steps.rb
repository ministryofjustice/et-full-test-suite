Then(/^I should be able to load diversity questionnaire form page$/) do
  et1_claim_submitted.diversity_link
  expect(diversity_pages.diversity_landing_page.main_content).to have_header
end

Given(/^a claimant answered all blank questions on the survey participant form$/) do
  @diversity = build(:diversity, :blank)
  diversity_load_page
  answer_diversity_page(@diversity)
end

When(/^the completed Diversity questionnaire form is submitted$/) do
  diversity_submit_form
end

Then(/^I should be on the Thank you page$/) do
  expect(diversity_pages.confirmation_page.main_content).to have_header
end

When(/^a claimant answered all questions on the survey participant form$/) do
  @diversity = build(:diversity, :not_blank)
  diversity_load_page
  answer_diversity_page(@diversity)
end

Then("the data is updated in ET Admin system") do  
  within_admin_window do
    expect(admin_pages.diversity_responses_page).to have_response_for(@diversity)
  end
end

Given("a claimant answered {string} on the survey participant form") do |string|
  @diversity = build(:diversity, :not_blank, religion: "Jehovah's Witnesses")
  diversity_load_page
  answer_diversity_page(@diversity)
end


Given("a claimant prefered not to answer ethnicity on the survey participant form") do
  @diversity = build(:diversity, :not_blank, ethnicity: :"ethnicity.prefer-not-to-say", ethnicity_subgroup: nil)
  diversity_load_page
  answer_diversity_page(@diversity)
end

When("user changed {string} to {string}") do |string, string2|
  @diversity = build(:diversity, :not_blank, claim_type: :"claim_type.redundancy-payment")
  diversity_pages.submission_form_page.main_content.claim_type_row.link.click
  diversity_pages.claim_type_page.set_for(@diversity)
end
