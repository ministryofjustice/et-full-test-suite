Given(/^I am on the ET3 employers contract claim page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  et3_answer_defend_claim_question
  et3_answer_representative
  et3_answer_disability_question
  expect(employers_contract_claim_page.main_header).to have_header
end

When(/^I successfully submit whether I wish to make an employers contract claim$/) do
  et3_employers_contract_claim
end

Then(/^I should be taken to the additional information page$/) do
  expect(additional_information_page.main_header).to have_header
end

When(/^I click on next without providing a response to employers contract claim question$/) do
  employers_contract_claim_page.next
end

