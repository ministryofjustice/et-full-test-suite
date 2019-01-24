Given(/^a claimant is on the Relationship Status page$/) do
  answers = build(:diversity, :blank)
  diversity_load_page
  diversity_pages.claim_type_page.set_for(answers)
  diversity_pages.sexual_identity_page.set_for(answers)
end

Then(/^Relationship Status page copy texts are displayed in the correct language$/) do
  expect(diversity_pages.relationship_status_page).to have_correct_translation
end