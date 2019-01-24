@javascript
Feature:
  As Claim outcome page
  I want to ensure that user can submit their Claim outcome in Welsh or in English

  Background: Claim outcome page
    Given a claimant is on Claim outcome page 

  Scenario: Verify copy text for Claim outcome page
    Then I can verify that the copy text on Claim outcome page displayed correctly

  Scenario: Submit without answering Claim outcome questions
    When I submit without answering Claim outcome questions
    Then I should on More about the claim page

  Scenario: Submit preferred outcomes
    When I submit my preferred outcomes
    Then I should on More about the claim page