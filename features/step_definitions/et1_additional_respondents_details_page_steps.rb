Given("a claimant is on Additional respondent's details page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:acas_number_reason, 1, :yes_acas)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_respondents_details_page.set(@respondent)
  et1_respondents_details_page.save_and_continue
end

Then("I can verify that the copy text on Additional respondent's details page displayed correctly") do
  et1_additional_respondents_details_page.main_content.additional_respondents.set(:"claims.additional_respondents.yes")
  et1_additional_respondents_details_page.main_content.respondent_2.no_acas_number.click
  expect(et1_additional_respondents_details_page.has_correct_translation?).to be true
end

When("I submit a blank Additional respondent's details page") do
  et1_additional_respondents_details_page.main_content.additional_respondents.set(:"claims.additional_respondents.yes")
  et1_additional_respondents_details_page.save_and_continue  
end

Then("I can verify blank error messages for Additional respondent's details page") do
  expect(et1_additional_respondents_details_page.has_correct_blank_validation?).to be true
end

When("entering invalid acas number for Additional respondent's details page") do
  et1_additional_respondents_details_page.main_content.additional_respondents.set(:"claims.additional_respondents.yes")
  et1_additional_respondents_details_page.main_content.respondent_2.acas_number.set('88234w')
  et1_additional_respondents_details_page.save_and_continue 
end

Then("I can verify an invalid acas number error message is displayed on Additional respondent's details page") do
  expect(et1_additional_respondents_details_page.has_correct_invalid_acas_number?).to be true
end

When("entering invalid postcode for Additional respondent's details page") do
  et1_additional_respondents_details_page.main_content.additional_respondents.set(:"claims.additional_respondents.yes")
  et1_additional_respondents_details_page.main_content.respondent_2.post_code.set('88234w')
  et1_additional_respondents_details_page.save_and_continue 
end

Then("I can verify an invalid UK postcode error message is displayed on Additional respondent's details page") do
  expect(et1_additional_respondents_details_page.has_correct_invalid_postcode?).to be true
end

When("I answer no to claims against more than one employer") do
  et1_additional_respondents_details_page.main_content.additional_respondents.set(:"claims.additional_respondents.no")
end

Then("I should on Employment details page") do
  et1_additional_respondents_details_page.save_and_continue
  expect(et1_employment_details_page.main_header).to have_page_header
end

When("I submit claim against three employers") do
  @respondent = FactoryBot.create_list(:acas_number_reason, 3, :yes_acas)
  et1_additional_respondents_details_page.set(@respondent)
end

Then("remove one of additional respondent") do
  et1_additional_respondents_details_page.remove_another_respondent
end

Then("I should only have two respondents to submit") do
  #Todo -
end