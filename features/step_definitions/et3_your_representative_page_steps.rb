Given(/^I am on the ET3 your representative page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  et3_answer_defend_claim_question
  expect(your_representative_page.main_header).to have_header
end

When(/^I successfully submit whether I have a representative$/) do
  et3_answer_representative
end

When(/^I click on next without providing whether I have a representative$/) do
  your_representative_page.next
end

Then(/^I should be taken to disability page$/) do
  expect(disability_page.main_header).to have_header
end
