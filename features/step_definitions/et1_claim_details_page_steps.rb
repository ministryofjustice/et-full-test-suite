Given("a claimant is on Claim details page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:acas_number_reason, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
end

Then("I can verify that the copy text on Claim details page displayed correctly") do
  et1_claim_details_page.main_content.upload_document.click
  et1_claim_details_page.main_content.claim_details_other_known_claimants.set(:"claims.claim_type.yes")
  expect(et1_claim_details_page.has_correct_translation?).to be true
end

When("I submit without answering Claim details questions") do
  et1_claim_details_page.save_and_continue
end

Then("an error message displaying Claim details must be answered") do
  expect(et1_claim_details_page.has_mandatory_error_message?).to be true
end

Then("I submit a claim statement by providing other people's name") do
  et1_claim_details_page.set(@claim)
end

Then("I submit a claim statement via RTF document") do
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
  et1_claim_details_page.set(@claim)
end

Then("I should be on Claim outcome page") do
  et1_claim_details_page.save_and_continue
  expect(et1_claim_outcome_page).to have_main_header
end