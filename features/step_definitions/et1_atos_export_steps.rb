Then(/^I can download the form and validate in PDF format$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_claim_pdf_for, user: @claimant[0]), timeout: 45, sleep: 2
  expect(atos_interface.download_from_any_zip_to_tempfile(:et1_claim_pdf_for, user: @claimant[0])).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Then(/^I can download the form and validate in TXT format$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_claim_txt_for, user: @claimant[0]), timeout: 45, sleep: 2
  expect(atos_interface.download_from_any_zip(:et1_claim_txt_for, user: @claimant[0])).to match_text_schema calculated_claim_matchers(user: @claimant[0], representative: @representative[0], respondents: @respondent, employment: @employment)
end

Then(/^I can download the uploaded CSV data and validate in TXT format$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1a_claim_txt_for, user: @claimant[0]), timeout: 45, sleep: 2
  expect(atos_interface.download_from_any_zip(:et1a_claim_txt_for, user: @claimant[0])).to match_text_schema calculated_et1a_claim_matchers(user: @claimant[0], respondents: @respondent)
end

Then(/^I can download the uploaded CSV data and validate in CSV format$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_claim_csv_for, user: @claimant[0]), timeout: 45, sleep: 2
end

Then(/^I can download the form and validate in Rich Text format$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_claim_rtf_for, user: @claimant[0]), timeout: 45, sleep: 2
end

Then(/^I can download the form and validate the TXT file contained 3 employers details$/) do
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_claim_txt_for, user: @claimant[0]), timeout: 45, sleep: 2
  expect(atos_interface.download_from_any_zip(:et1_claim_txt_for, user: @claimant[0])).to match_text_schema calculated_claim_matchers(user: @claimant[0], representative: @representative[0], respondents: @respondent, employment: @employment)
end

Then("I can download the form and validate that the filename starts with {string}") do |string|
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_interface }.to eventually have_zip_file_containing(:et1_filename_start_with, user: @claimant[0], local_office: string), timeout: 45, sleep: 2
  expect(atos_interface.download_from_any_zip_to_tempfile(:et1_claim_pdf_for, user: @claimant[0])).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Then("I can download the form from the secondary queue and that the filename starts with {string}") do |string|
  within_admin_window do
    api = EtFullSystem::Test::AdminApi.new
    expect { api.claimants_api }.to eventually include(a_hash_including(first_name: @claimant[0].dig(:first_name))), timeout: 45, sleep: 2
    admin_pages.jobs_page.run_export_claims_cron_job
  end
  expect { atos_secondary_interface }.to eventually have_zip_file_containing(:et1_filename_start_with, user: @claimant[0], local_office: string), timeout: 45, sleep: 2
  expect(atos_secondary_interface.download_from_any_zip_to_tempfile(:et1_claim_pdf_for, user: @claimant[0])).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end