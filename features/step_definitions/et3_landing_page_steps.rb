Given(/^I am on the ET3 landing page$/) do
  load_et3_start_page
end

Then(/^introduction page copy texts are displayed in the correct language$/) do
  expect(start_page.has_correct_translation?).to be true
end

When(/^I click on the begin this form button$/) do
  start_page.next
end

Then(/^I should be taken to the respondents details page$/) do
  expect(respondents_details_page).to have_header
end

Then(/^I should see other relevant links$/) do
  expect(start_page.sidebar.claim_link['href']).to eq t('components.sidebar.claim_href')
  expect(start_page.sidebar.response_link['href']).to eq t('components.sidebar.response_href')
  expect(start_page.sidebar.contact_link['href']).to eq t('components.sidebar.contact_href')
  expect(start_page.sidebar.download_link['href']).to eq t('components.sidebar.download_href')
  expect(start_page.sidebar.more_category_link['href']).to eq t('components.sidebar.more_category_href')
end