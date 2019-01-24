Given(/^a claimant is on the Confirmation page$/) do
  answers = build(:diversity, :blank)
  diversity_load_page
  diversity_pages.claim_type_page.set_for(answers)
  diversity_pages.sexual_identity_page.set_for(answers)
  diversity_pages.relationship_status_page.set_for(answers)
  diversity_pages.age_group_caring_responsibilities_page.set_for(answers)
  diversity_pages.religion_page.set_for(answers)
  diversity_pages.ethnic_group_page.set_for(answers)
  diversity_pages.health_page.set_for(answers)
  diversity_pages.pregnancy_page.set_for(answers)
  diversity_pages.submission_form_page.submit_form
end

Then(/^Confirmation page copy texts are displayed in the correct language$/) do
  expect(diversity_pages.confirmation_page).to have_correct_translation
end