@diversity
@javascript
Feature:
  As a claimant
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Landing page
    Given a claimant is on the Landing page

  Scenario: Verify page copy
    Then Landing page copy texts are displayed in the correct language
