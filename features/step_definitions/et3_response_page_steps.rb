Given(/^I am on the ET3 response page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  expect(response_page.main_header).to have_header
end

When(/^I successfully submit my response$/) do
  et3_answer_defend_claim_question
end

Then(/^I should be taken to your representative page$/) do
  expect(your_representative_page.main_header).to have_header
end

When(/^I try to continue without providing a response to claim question$/) do
  response_page.next
end

Then(/^I should see the error message saying the response to claim cant be blank$/) do
  expect(response_page.error_summary).to have_error_header
  expect(response_page.defend_claim_question).to have_error
end
