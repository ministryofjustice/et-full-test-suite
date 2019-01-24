@javascript
Feature:
  As More about the claim page
  I want to ensure that user can submit their More about the claim in Welsh or in English

  Background: More about the claim page
    Given a claimant is on More about the claim page 

  Scenario: Verify copy text for More about the claim page
    Then I can verify that the copy text on More about the claim page displayed correctly

  Scenario: Submit without adding additional information about your claim
    When I submit without adding additional information about your claim
    Then I should be on Check your claim page

  Scenario: Submit an additional information about your claim
    When I submit an additional information about your claim
    Then I should be on Check your claim page