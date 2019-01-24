@javascript
Feature:
  As a claimant
  I would like to select whether I submit my application in Welsh or English
  So that I can use my preferred language

  Scenario: Verify copy texts
    Given a claimant is on the Return to your claim page
    Then Return to your claim copy texts are displayed in the correct language
  
  Scenario: Find my claim
    Given I'm a return claimant
    When I enter my claim details
    Then I should be taken to where I was left off

  Scenario: 'Start a new claim' link
    Given a claimant is on the Return to your claim page
    When I click Start a new claim
    Then I should be taken to Start a new claim page