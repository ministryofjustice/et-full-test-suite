Given(/^I am on the ET3 earnings and benefits page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  expect(earnings_and_benefits_page.main_header).to have_header
end

When(/^I successfully submit information about my earnings and benefits$/) do
  et3_answer_earnings_and_benefits
end

Then(/^I should be taken to the response page$/) do
  expect(response_page.main_header).to have_header
end

When(/^I click on next without providing the optional earnings and benefits details$/) do
  earnings_and_benefits_page.next
end
