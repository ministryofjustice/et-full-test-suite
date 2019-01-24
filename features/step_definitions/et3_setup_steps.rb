Given(/^an employer responds to a claim$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given(/^an employer responds to a claim with no respresentative$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_no_representative)
end

Given(/^an employer respond yes to 'Are the dates of employment given by the claimant correct'$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given("an employer responds to a claim with case number starting {string}") do |string|
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, case_number: "#{string}")
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

When(/^an employer responds to a claim with an additional information$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, :upload_additional_information)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end