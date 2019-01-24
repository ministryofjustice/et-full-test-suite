Given(/^I am on the ET3 form submission page$/) do
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
  et3_confirmation_of_supplied_details

  @my_et3_reference = form_submission_page.reference_number.text
end

Then(/^I should see my application reference number$/) do
  expect(form_submission_page).to have_submission_confirmation
  expect(form_submission_page).to have_reference_number
end

Then(/^I should see the date\/time my application was submitted$/) do
  expect(form_submission_page).to have_submission_date
end

Then(/^I can download a PDF of my application$/) do
  expect(form_submission_page).to have_valid_pdf_download
end

Then(/^I can return to gov.uk$/) do
  form_submission_page.return_to_govuk_button.click
  expect(current_url).to eql 'https://www.gov.uk/'
end
