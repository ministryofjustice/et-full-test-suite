@javascript
Feature:
  As Employment details page
  I want to ensure that user can submit their Employment details in Welsh or in English

  Background: Employment details page
    Given a claimant is on Employment details page 

  Scenario: Verify copy text for Employment details page
    Then I can verify that the copy text on Employment details page displayed correctly

  Scenario: No to Employment details
    When I submit without providing Employment details
    Then I should on About the claim page

  Scenario: Submit without answering work situation
    When I submit without answering work situation
    Then I should get an error that work situation must be selected

  Scenario: Submit without answering Employment details
    When I submit without answering Employment details
    Then I should on About the claim page

  Scenario: Invalid employment start and end date
    When I submit an invalid start and end date
    Then I should get an error message that the date provided are invalid

  Scenario: Amount entered for a period notice
    When I submit my weeks or months paid for a period notice
    Then I should on About the claim page