@javascript
Feature:
  As Submission page
  I want to ensure that user can view the submission details in Welsh or in English

  Scenario: with a representative, respondent and claimant
    Given an employee making a claim
    And the claimant is on the Submission page
    Then I should see a valid submission page

  Scenario: multiple claimants by uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    And the claimant is on the Submission page
    Then I should see a valid submission page

  Scenario: 2 people making a claim
    Given 2 employees making a claim
    And the claimant is on the Submission page
    Then I should see a valid submission page

  Scenario: Making claim against 3 employers
    Given an employee making a claim against 3 employers
    And the claimant is on the Submission page
    Then I should see a valid submission page

  Scenario: RTF format
    Given an employee making a claim by uploading a Rich Text Format document
    And the claimant is on the Submission page
    Then I should see a valid submission page
