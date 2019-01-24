Then("I should see valid claim submitted page") do
  if @respondent[0][:work_office]
    office = @respondent[0][:work_office]
  else
    office = @respondent[0][:office]
  end
  expect(et1_claim_submitted.has_correct_translation?(@claim_number, @claim[:rtf_file], @claimant[0][:group_claims_csv], office)).to be true
end

Given("claimant home postcode {string} then submission office will be {string}") do |string, string2|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:no_work_address, 1, post_code: string, office: string2)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given("claimant work postcode {string} then submission office will be {string}") do |string, string2|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:no_work_address, 1, post_code: string, office: string2)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)
end

Given("a group claimaints submitting an ET1 form by uploading CSV and Rich Text Format documents") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:conciliation_acas_number, 1, :yes_acas)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create_list(:claim, 1, :upload_your_claim_statement)[0]
end