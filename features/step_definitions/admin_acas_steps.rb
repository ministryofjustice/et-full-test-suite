Given(/^I am an ACAS administrator$/) do
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)
end

When(/^I enter an ACAS certificate number in the ACAS search field$/) do
  if ENV['ENVIRONMENT'] == 'local'
    @certificate = build(:acas_mock_certificate, :mock_valid)
  else
    @certificate = build(:acas_certificate, :valid)
  end
  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end

When(/^I enter an invalid format ACAS certificate number$/) do
  if ENV['ENVIRONMENT'] == 'local'
    @certificate = build(:acas_mock_certificate, :mock_invalid)
  else
    @certificate = build(:acas_certificate, :invalid)
  end
  
  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end

When(/^I enter a not found ACAS certificate number$/) do
  @certificate = build(:acas_mock_certificate, :mock_not_found)
  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end

When(/^I enter a 'server error' ACAS certificate number$/) do
  @certificate = build(:acas_mock_certificate, :mock_server_error)
  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end

Then(/^I can view the contents of the acas document$/) do
  expect(admin_pages.acas_search_results_page).to have_valid_certificate_for(@certificate)
end


Then(/^the system should return feedback from acas 'No certificate returned from ACAS for R000201\/18\/68'$/) do
  expect(admin_pages.acas_search_results_page).to have_not_found_certificate_message_for(@certificate)
end


Then(/^the system should return feedback from acas 'Please enter a valid certificate number'$/) do
  expect(admin_pages.acas_search_results_page).to have_invalid_certificate_message_for(@certificate)
end


Then(/^the system should return feedback from acas 'There was a problem with the ACAS service \-  please try again later'$/) do
  expect(admin_pages.acas_search_results_page).to have_server_error_message_for(@certificate)
end


Then(/^I can download the contents of the acas document$/) do
  expect(admin_pages.acas_search_results_page).to have_download_link_for(@certificate)
end

When(/^an ET Administrator with full access can view successful Acas Certificate log$/) do
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)

  if ENV['ENVIRONMENT'] == 'local'
    @certificate = build(:acas_mock_certificate, :mock_valid)
  else
    @certificate = FactoryBot.create_list(:acas_certificate, 1, :valid, number: 'MU000086/18/82', method_of_issue: 'Letter')[0]
  end

  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end

Then("I can see who has downloaded ACAS certificate {string}") do |string|
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    acas_details_from_log = api.acas_certificate_logs_api.select { |a| a['certificate_number'] == "#{@certificate.number}"}[0]
    expect(@certificate.number).to eq(acas_details_from_log['certificate_number'])
    expect(@certificate.user_id).to eq(acas_details_from_log["#{::EtFullSystem::Test::Configuration.admin_username}"])
    expect("#{string}").to eq(acas_details_from_log['message'])
    if @certificate.method_of_issue.present?
      expect(@certificate.method_of_issue).to eq(acas_details_from_log['method_of_issue'])
    else
      expect(nil).to eq(acas_details_from_log['method_of_issue'])
    end
  end
end

When(/^an ET Administrator with full access ca view invalid Acas Certificate log$/) do
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)

  if ENV['ENVIRONMENT'] == 'local'
    @certificate = build(:acas_mock_certificate, :mock_invalid)
  else
    @certificate = create(:acas_certificate, :invalid)
  end

  admin_pages.any_page.menu.choose_acas_certificates
  admin_pages.acas_search_page.search(@certificate.number)
end
