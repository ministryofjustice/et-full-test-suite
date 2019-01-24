Given("the claimant is on the Submission page") do
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
end


Then(/^I should see a valid submission page$/) do
  et1_submission_page.has_correct_translation?(claimants: @claimant, respondents: @respondent, claim: @claim, employment: @employment, representative: @representative.first)
end
