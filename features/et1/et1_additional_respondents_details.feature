@javascript
Feature:
  As Additional respondent's details page
  I want to ensure that user can submit their Additional respondent's details in Welsh or in English

  Background: Additional respondent's details page
    Given a claimant is on Additional respondent's details page 

  Scenario: Verify copy text for Additional respondent's details page
    Then I can verify that the copy text on Additional respondent's details page displayed correctly

  Scenario: Verify blank submission for error messages
    When I submit a blank Additional respondent's details page
    Then I can verify blank error messages for Additional respondent's details page

  Scenario: Invalid UK postcode
    When entering invalid postcode for Additional respondent's details page
    Then I can verify an invalid UK postcode error message is displayed on Additional respondent's details page

  Scenario: Invalid Acas number
    When entering invalid acas number for Additional respondent's details page
    Then I can verify an invalid acas number error message is displayed on Additional respondent's details page

  Scenario: Submit claim against one employer
    When I answer no to claims against more than one employer
    Then I should on Employment details page

  Scenario: Submit claim against three employers
    When I submit claim against three employers
    Then I should on Employment details page

  # Scenario: Remove respondent
  #   When I submit claim against three employers
  #   And remove one of additional respondent
  #   Then I should only have two respondents to submit