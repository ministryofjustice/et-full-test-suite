When(/^the completed Employment Tribunal response form is submitted$/) do
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

When(/^an employer responds to mandatory questions$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :et3_claimant_optionals)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_optionals)
  @representative = FactoryBot.create_list(:representative, 1, :et3_no_representative)

  start_a_new_et3_response
  et3_answer_respondents_details

  user = @claimant[0]
  claimants_details_page.agree_with_employment_dates_question.set_for(user)
  claimants_details_page.next
  earnings_and_benefits_page.next
  response_page.defend_claim_question.set_for(user)
  response_page.next
  et3_answer_representative
  et3_answer_disability_question
  employers_contract_claim_page.next
  additional_information
  confirmation_of_supplied_details_page.next

  @my_et3_reference = form_submission_page.reference_number.text
end

When("an employer responds to a claim with special characters in the company's name") do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :et3_claimant_optionals)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_optionals, name: 'N/A_+*-@_.')
  @representative = FactoryBot.create_list(:representative, 1, :et3_no_representative)

  start_a_new_et3_response
  et3_answer_respondents_details

  user = @claimant[0]
  claimants_details_page.agree_with_employment_dates_question.set_for(user)
  claimants_details_page.next
  earnings_and_benefits_page.next
  response_page.defend_claim_question.set_for(user)
  response_page.next
  et3_answer_representative
  et3_answer_disability_question
  employers_contract_claim_page.next
  additional_information
  confirmation_of_supplied_details_page.next

  @my_et3_reference = form_submission_page.reference_number.text
end