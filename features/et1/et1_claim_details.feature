@javascript
Feature:
  As Claim details page
  I want to ensure that user can submit their Claim details in Welsh or in English

  Background: Claim details page
    Given a claimant is on Claim details page 

  Scenario: Verify copy text for Claim details page
    Then I can verify that the copy text on Claim details page displayed correctly

  Scenario: Submit without answering Claim details questions
    When I submit without answering Claim details questions
    Then an error message displaying Claim details must be answered

  Scenario: Provide other people's name when making a claim statement
    When I submit a claim statement by providing other people's name
    Then I should be on Claim outcome page

  Scenario: Upload RTF document
    When I submit a claim statement via RTF document
    Then I should be on Claim outcome page