Given(/^an employee making a claim$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given(/^an employee making a claim without a respresentative$/) do
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given(/^2 employees making a claim$/) do
  @claimant = FactoryBot.create_list(:claimant, 2, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given(/^7 employees making a claim by uploading CSV file$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given(/^an employee making a claim by uploading a Rich Text Format document$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create_list(:claim, 1, :upload_your_claim_statement)[0]
end

Given(/^an employee making a claim against 3 employers$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 3)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given("a claimant submitted an ET1 form without providing a work address {string}") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :yes_acas, post_code: string)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)

  start_a_new_et1_claim
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

Given("a claimant submitted an ET1 form with work address WD187SQ") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)

  start_a_new_et1_claim
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

When("a claimant submitted an ET1 with special characters in the first and last name") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, first_name: 'N/A.*_', last_name: "N/A.*#{Time.now.to_i}")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)

  start_a_new_et1_claim
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

Given("a claimant submitted an ET1 with no employment details") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @claim = FactoryBot.create_list(:claim, 1, :upload_your_claim_statement)[0]
end

Given("a claimant submitted an ET1 who live outside UK") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, country: :"simple_form.options.claimant.address_country.other", post_code: "1065^&%$£@():?><*&")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @claim = FactoryBot.create_list(:claim, 1, :upload_your_claim_statement)[0]
end
