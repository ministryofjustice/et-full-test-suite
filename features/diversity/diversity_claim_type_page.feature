@diversity
@javascript
Feature:
  As a claimant on the Claim Type page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Claim Type page
    Given a claimant is on the Claim Type page

  Scenario: Verify page copy
    Then Claim Type page copy texts are displayed in the correct language
