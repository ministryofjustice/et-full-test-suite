Given(/^a claimant is on the Religion page$/) do
  answers = build(:diversity, :blank)
  diversity_load_page
  diversity_pages.claim_type_page.set_for(answers)
  diversity_pages.sexual_identity_page.set_for(answers)
  diversity_pages.relationship_status_page.set_for(answers)
  diversity_pages.age_group_caring_responsibilities_page.set_for(answers)
end

Then(/^Religion page copy texts are displayed in the correct language$/) do
  expect(diversity_pages.religion_page).to have_correct_translation
end