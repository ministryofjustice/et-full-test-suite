Given("a claimant is on Claim outcome page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:acas_number_reason, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
end

Then("I can verify that the copy text on Claim outcome page displayed correctly") do
  expect(et1_claim_outcome_page.has_correct_translation?).to be true
end

Then("I submit without answering Claim outcome questions") do
  et1_claim_outcome_page.save_and_continue
end

When("I submit my preferred outcomes") do
  et1_answer_claim_outcome_questions
end

Then("I should on More about the claim page") do
  expect(et1_more_about_the_claim_page.main_header).to have_page_header
end