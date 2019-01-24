Given(/^I am on the ET3 claimants details page$$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  start_a_new_et3_response  
  et3_answer_respondents_details
end

Then("Claimants details page copy texts are displayed in the correct language") do
  claimants_details_page.agree_with_early_conciliation_details_question.no.click
  claimants_details_page.agree_with_employment_dates_question.no.click
  claimants_details_page.agree_with_claimants_description_of_job_or_title_question.no.click

  expect(claimants_details_page.has_correct_translation?).to be true
end

When(/^I successfully submit all the claimants details$/) do
  et3_answer_claimants_details
end

When(/^I successfully submit required claimants details only$/) do
  et3_answer_required_claimants_details
end

Then(/^I should be taken to the earnings and benefits page$/) do
  expect(earnings_and_benefits_page.main_header).to have_header
end

When(/^I click on next without providing the required claimants details$/) do
  earnings_and_benefits_page.next
end

Then(/^I should see the error message saying the claimants details cant be blank$/) do
  expect(claimants_details_page.error_summary).to have_error_list
end

But(/^I do not provide the correct employment dates or give a reason$/) do
  claimants_details_page.next
end

When(/^I select no to are the dates given by the claimant correct$/) do
  claimants_details_page.agree_with_employment_dates_question.no.click
end

Then(/^I should see the error message saying the further information about dates cant be blank$/) do
  expect(claimants_details_page.agree_with_employment_dates_question.employment_start).to have_error_blank
  expect(claimants_details_page.agree_with_employment_dates_question.employment_end).to have_error_blank
  expect(claimants_details_page.agree_with_employment_dates_question.disagree_employment).to have_error_blank
end