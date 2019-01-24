Given(/^I am on the ET3 additional information page$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, :upload_additional_information)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  et3_answer_defend_claim_question
  et3_answer_representative
  et3_answer_disability_question
  et3_employers_contract_claim
  expect(additional_information_page.main_header).to have_header
end

When(/^I successfully upload my file with additional information$/) do
  additional_information
end

When(/^I click on next without providing the additional information$/) do
  additional_information_page.next
end

Then(/^I should see my file has been added$/) do
  expect(confirmation_of_supplied_details_page.confirmation_of_additional_information_answers.upload_additional_information_row).to have_upload_additional_information_answer
end

Then(/^I should be taken to the confirmation of supplied details page$/) do
  expect(confirmation_of_supplied_details_page.main_header).to have_header
end