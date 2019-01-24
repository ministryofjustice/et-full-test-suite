Given /^a claimant continued from Saving your claim page$/ do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  start_a_new_et1_claim
  @claim_number = et1_application_number_page.main_content.claims_number.text
  et1_answer_login
end

Then(/^an email is sent to notify user that a claim has been started$/) do
  et1_email = EtFullSystem::Test::Et1ClaimContinueEmailHtml.find(claim_number: @claim_number)
  expect(et1_email.has_correct_subject_for_complete_your_claim?).to be true
end

Given /^a claimant completes an ET1 form$/ do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)


  start_a_new_et1_claim
  @claim_number = et1_application_number_page.main_content.claims_number.text
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
  et1_answer_claim_outcome_questions
  et1_answer_more_about_the_claim_questions
  et1_submit_claim

end

Then(/^an email is sent to notify user that a claim has been successfully submitted$/) do
  et1_email = EtFullSystem::Test::Et1ClaimCompletedEmailHtml.find(claim_number: @claim_number)
  date = Time.now
  expect(et1_email.submission_submitted).to eq(t('claim_confirmations.show.submission_details.submission_with_office', date: date.strftime("%d #{t("date.month_names")[date.month]} %Y"), office: @respondent[0][:work_office]))
  expect(et1_email.has_correct_subject_for_claim_submitted?).to be true
end

When(/^a respondent completes an ET3 form$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
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

Then(/^an email is sent to notify user that a respondent has been successfully submitted$/) do
  email_sent = ::EtFullSystem::Test::Et3ResponseEmailHtml.find(reference: @my_et3_reference, locale: ::EtFullSystem::Test::Messaging.instance.current_locale)
  expect(email_sent).to have_correct_content_for(submission_date: form_submission_page.submission_date.text, reference: @my_et3_reference)
end
