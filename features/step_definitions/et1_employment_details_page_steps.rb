Given("a claimant is on Employment details page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:acas_number_reason, 1, :yes_acas)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
end

Then("I can verify that the copy text on Employment details page displayed correctly") do
  et1_employment_details_page.main_content.your_employment_details.set(:"claims.employment.yes")
  et1_employment_details_page.main_content.employment_current_situation.set(:"simple_form.options.employment.current_situation.notice_period")
  et1_employment_details_page.main_content.worked_notice_period_or_paid_in_lieu.period_of_notice.set(:"claims.employment.yes")
  expect(et1_employment_details_page.has_correct_translation?).to be true
end

Then("I submit without providing Employment details") do
  et1_employment_details_page.main_content.your_employment_details.set(:"claims.employment.no")
end

Then("I should on About the claim page") do
  et1_employment_details_page.save_and_continue
  expect(et1_claim_type_page.main_header).to have_page_header
end

Then("I submit without answering work situation") do
  et1_employment_details_page.main_content.your_employment_details.set(:"claims.employment.yes")
  et1_employment_details_page.save_and_continue
end

Then("I should get an error that work situation must be selected") do
  expect(et1_employment_details_page.has_correct_error_message_for_current_work_situation?).to be true
end

When("I submit without answering Employment details") do
  et1_employment_details_page.main_content.your_employment_details.set(:"claims.employment.yes")
  et1_employment_details_page.main_content.employment_current_situation.set(:"simple_form.options.employment.current_situation.notice_period")
end

When("I submit an invalid start and end date") do
  et1_employment_details_page.main_content.your_employment_details.set(:"claims.employment.yes")
  et1_employment_details_page.main_content.employment_current_situation.set(:"simple_form.options.employment.current_situation.notice_period")
  et1_employment_details_page.main_content.employment_start_date.set('0/0/0')
  #TODO
  # et1_employment_details_page.main_content.employment_end_date.set('0/0/0')
  et1_employment_details_page.save_and_continue
end

Then("I should get an error message that the date provided are invalid") do
  expect(et1_employment_details_page.has_correct_invalid_date_error_messages?).to be true
end

When("I submit my weeks or months paid for a period notice") do
  @employment = FactoryBot.create(:employment)
  et1_employment_details_page.set(@employment)
end
