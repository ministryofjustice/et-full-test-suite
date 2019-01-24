@javascript
Feature:
  As a claimant
  I would like to select whether I submit my application in Welsh or English
  So that I can use my preferred language

  Background: Apply page
    Given a claimant is on the Your feedback page 

  Scenario: Verify copy texts
    Then Your feedback page copy texts are displayed in the correct language
  
  Scenario: Submit a feedback
    When I submit Your feedback
    Then I should see thank you for your feedback message