@javascript
Feature:
  As a claimant
  I would like to select whether I submit my application in Welsh or English
  So that I can use my preferred language

  Background: Apply page
    Given a claimant is on the Apply page 

  Scenario: Verify copy texts
    Then Apply page copy texts are displayed in the correct language
  
  Scenario: 'Your feedback' link
    When user click on Your feedback link
    Then user is taken to the feedback page

  Scenario: 'Learn about when you can apply' link  
    When user click on Learn about when you can apply link
    Then user is taken to the time limits page

  Scenario: 'Acas early conciliaton certificate number' link
    When user click on Acas early conciliation certificate number
    Then user is taken to the Acas early conciliation page

  # Scenario: Support links
  #   When user click on Guide link
  #   Then user is taken to the Guide page

  #   When user click on Contact us link
  #   Then user is taken to the Contact us page