Given(/^a claimant is on the Claim Type page$/) do
  diversity_load_page
end

Then(/^Claim Type page copy texts are displayed in the correct language$/) do
  expect(diversity_pages.claim_type_page).to have_correct_translation
end