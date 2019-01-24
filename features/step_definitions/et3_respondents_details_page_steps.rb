Given(/^I am on the ET3 respondents details page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  start_a_new_et3_response
end

Then("Respondents details page copy texts are displayed in the correct language") do
  expect(respondents_details_page.has_correct_translation?).to be true
end

When(/^I successfully submit all the respondents details$/) do
  et3_answer_respondents_details
end

When(/^I successfully submit the required respondents details only$/) do
  et3_answer_required_espondents_details
end

Then(/^I should be taken to the claimants details page$/) do
  expect(claimants_details_page.main_header).to have_header
end

When(/^I click on next without providing the required respondents details$/) do
  respondents_details_page.next
end

Then(/^I should see the error message saying the respondents details cant be blank$/) do
  expect(respondents_details_page.has_correct_blank_error_messages?).to be true
end
