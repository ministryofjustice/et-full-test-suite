@javascript
Feature:
  As Respondent's details page
  I want to ensure that user can submit their Respondent's details in Welsh or in English

  Background: Respondent's details page
    Given a claimant is on Respondent's details page 

  Scenario: Verify copy text for Respondent's details page
    Then I can verify that the copy text on Respondent's details page displayed correctly

  Scenario: Verify blank submission for error messages
    When I submit a blank Respondent's details page
    Then I can verify blank error messages for Respondent's details page

  Scenario: Invalid UK postcode error message
    When entering invalid postcode for Respondent's details page
    Then I can verify an invalid UK postcode is being used for Respondent's details page

  Scenario: Yes to acas
    When I submit yes to Acas early conciliation certificate number
    Then I should be taken to Employment details page

  Scenario: No to acas
    When I submit no to Acas early conciliation certificate number
    Then I should be taken to Employment details page
