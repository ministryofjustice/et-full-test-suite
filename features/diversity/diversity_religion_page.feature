@diversity
@javascript
Feature:
  As a claimant on the Religion page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Religion page
    Given a claimant is on the Religion page

  Scenario: Verify page copy
    Then Religion page copy texts are displayed in the correct language
