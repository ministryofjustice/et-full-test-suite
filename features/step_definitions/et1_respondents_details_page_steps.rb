Given("a claimant is on Respondent's details page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
end

Then("I can verify that the copy text on Respondent's details page displayed correctly") do
  et1_respondents_details_page.main_content.same_address.set(:"simple_form.labels.respondent.no")
  et1_respondents_details_page.main_content.no_acas_number.click
  expect(et1_respondents_details_page.has_correct_translation?).to be true
end

When("I submit a blank Respondent's details page") do
  et1_respondents_details_page.main_content.same_address.set(:"simple_form.labels.respondent.no")
  et1_respondents_details_page.main_content.no_acas_number.click
  et1_respondents_details_page.save_and_continue
end

Then("I can verify blank error messages for Respondent's details page") do
  expect(et1_respondents_details_page.has_correct_blank_validation_error_messages?).to be true
end

When("entering invalid postcode for Respondent's details page") do
  et1_respondents_details_page.main_content.same_address.set(:"simple_form.labels.respondent.no")
  et1_representatives_details_page.main_content.post_code.set('UTOI&*"?£$')
  et1_respondents_details_page.save_and_continue
end

Then("I can verify an invalid UK postcode is being used for Respondent's details page") do
  expect(et1_respondents_details_page.has_correct_error_message_for_invalid_uk_postcode?).to be true
end

When("I submit yes to Acas early conciliation certificate number") do
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  et1_respondents_details_page.set(@respondent)
  et1_respondents_details_page.save_and_continue
end

When("I submit no to Acas early conciliation certificate number") do
  @respondent = FactoryBot.create_list(:acas_number_reason, 1, :no_acas)
  et1_respondents_details_page.set(@respondent)
  et1_respondents_details_page.save_and_continue
end

When("I should be taken to Employment details page") do
  expect(et1_additional_respondents_details_page.main_header).to have_page_header
end
