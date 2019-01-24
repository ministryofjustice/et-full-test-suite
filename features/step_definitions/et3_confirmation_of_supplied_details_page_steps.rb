Given(/^I am on the ET3 confirmation of supplied details page$/) do
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
  et3_employers_contract_claim
  additional_information
end

When(/^I submit my form$/) do
  et3_confirmation_of_supplied_details
end

When(/^I am taken to the form submission page$/) do
  expect(form_submission_page).to have_header
end

Then(/^I should see my answers to the questions$/) do
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_respondents_details_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_claimants_details_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_earnings_and_benefits_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_response_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_your_representative_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_your_representatives_details_answers
  expect(confirmation_of_supplied_details_page).to have_confirmation_of_employer_contract_claim_answers
end

When(/^I change my answer on the employer contract form page$/) do
  et3_edit_answer
  et3_answer_no_to_employers_contract_claim
  additional_information
end

Then(/^I should see my updated answer on the confirmation of supplied details page$/) do
  if ::EtFullSystem::Test::Messaging.instance.current_locale == :cy
    expect(et3_displays_edited_answer).to eq 'Nac oes'
  else
    expect(et3_displays_edited_answer).to eq 'No'
  end
end

Then(/^I should see each page section has a back to top link$/) do
  expect(confirmation_of_supplied_details_page.confirmation_of_respondents_details_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_claimants_details_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_earnings_and_benefits_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_response_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_your_representative_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_your_representatives_details_answers).to have_back_to_top
  expect(confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers).to have_back_to_top
end

Then(/^I click on back to the top$/) do
  confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers.back_to_top.click
end

Then(/^I should be taken to the top of the confirmation of supplied details page$/) do
  expect(current_url).to end_with '#content'
end