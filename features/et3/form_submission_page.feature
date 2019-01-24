@et3 @javascript

Feature: Form submission page

Background: ET3 form submission page
  Given I am on the ET3 form submission page

  Scenario: Displays application reference number
    Then I should see my application reference number

  Scenario: Displays date and time of application submission
    Then I should see the date/time my application was submitted

  Scenario: Download PDF
    Then I can download a PDF of my application

  Scenario: Return to gov.uk
    Then I can return to gov.uk
