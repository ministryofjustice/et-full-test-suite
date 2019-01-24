Given(/^a claimant is on the Sexual Identity page$/) do
  answers = build(:diversity, :blank)
  diversity_load_page
  diversity_pages.claim_type_page.set_for(answers)
end

Then(/^Sexual Identity page copy texts are displayed in the correct language$/) do
  expect(diversity_pages.sexual_identity_page).to have_correct_translation
end