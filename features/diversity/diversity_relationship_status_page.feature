@diversity
@javascript
Feature:
  As a claimant on the Relationship Status page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Relationship Status page
    Given a claimant is on the Relationship Status page

  Scenario: Verify page copy
    Then Relationship Status page copy texts are displayed in the correct language
