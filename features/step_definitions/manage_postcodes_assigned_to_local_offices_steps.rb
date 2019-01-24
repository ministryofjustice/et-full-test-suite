Given("an administrator login") do
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)
end

When("a new postcode {string} is added to {string} office") do |string, string2|
  admin_pages.any_page.menu.click_office_postcodes
  admin_pages.office_postcodes_page.add_new_office_postcode(string, string2)
end

Then("the new postcode is saved on the system") do
  admin_pages.office_postcodes_page.has_successfully_created_error_msg?
end

Given("a postcode {string} is assigned to {string} office") do |string, string2|
  admin_pages.any_page.menu.click_office_postcodes
  admin_pages.office_postcodes_page.add_new_office_postcode(string, string2)
end

When("I reassign the postcode to {string} office") do |string|
  admin_pages.any_page.menu.click_office_postcodes
  admin_pages.office_postcodes_page.edit_postcode
  admin_pages.new_office_postcodes_page.edit_office_address(string)
end

Then("the postcode will be assigned to the different office and no longer assigned to the original office") do
  admin_pages.office_postcodes_page.has_successfully_edited_error_msg?
end

Given("an existing postcode {string} is assigned to {string} office") do |string, string2|
  admin_pages.any_page.menu.click_office_postcodes
  admin_pages.office_postcodes_page.add_new_office_postcode(string, string2)
end

When("I delete postcode {string}") do |string|
  admin_pages.any_page.menu.click_office_postcodes
  admin_pages.office_postcodes_page.delete_postcode
end

Then("the deleted postcode is no longer saved in the system") do
  admin_pages.office_postcodes_page.has_successfully_delete_error_msg?
end

When("a claimant submitted an ET1 form using postcode {string}") do |string|
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