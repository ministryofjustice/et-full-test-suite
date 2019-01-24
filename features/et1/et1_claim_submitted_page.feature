@javascript
Feature:
  As Claim submitted page
  I want to ensure that user can view the claim submitted page in Welsh or in English

  Scenario: Validate claim submitted page
    Given an employee making a claim
    When the completed form is submitted
    Then I should see valid claim submitted page

  Scenario: Claimant home postcode BS11DZ will be forwarded to Bristol office
    Given claimant home postcode 'BS11DZ' then submission office will be 'Bristol, Bristol Civil and Family Justice Centre, 2 Redcliff Street, Bristol, BS1 6GR'
    When the completed form is submitted
    Then I should see valid claim submitted page

  Scenario: Claimant's work address is unknown
    Given claimant work postcode 'Z12LL' then submission office will be 'Default, Alexandra House, 14-22 The Parsonage, Manchester M3 2JA'
    When the completed form is submitted
    Then I should see valid claim submitted page

  Scenario: Submission details includes RTF and CSV files
    Given a group claimaints submitting an ET1 form by uploading CSV and Rich Text Format documents
    When the completed form is submitted
    Then I should see valid claim submitted page

  Scenario: Submission details include CSV files
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then I should see valid claim submitted page

  Scenario: Submission details include RTF files
    Given an employee making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then I should see valid claim submitted page