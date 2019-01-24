@javascript
Feature:
  As About the claim page
  I want to ensure that user can submit their About the claim in Welsh or in English

  Background: About the claim page
    Given a claimant is on About the claim page 

  Scenario: Verify copy text for About the claim page
    Then I can verify that the copy text on About the claim page displayed correctly

  Scenario: Select all claim types
    When I select all claim types
    Then I should be on Claim details page

  Scenario: Submit without selecting a claim type
    When I submit without selecting a claim type
    Then I an error message displaying claim types must be selected