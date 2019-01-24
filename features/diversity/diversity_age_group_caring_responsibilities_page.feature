@diversity
@javascript
Feature:
  As a claimant on the Age Group Caring Responsibilities page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Age Group Caring Responsibilities page
    Given a claimant is on the Age Group Caring Responsibilities page

  Scenario: Verify page copy
    Then Age Group Caring Responsibilities page copy texts are displayed in the correct language