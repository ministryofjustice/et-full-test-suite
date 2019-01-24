@et3 @javascript

Feature: Respondents details page

Background: ET3 respondents details page
  Given I am on the ET3 respondents details page

Scenario: Verify Respondents details copy
    Then Respondents details page copy texts are displayed in the correct language
  
Scenario: Successfully submits all respondents details 
  When I successfully submit all the respondents details
  Then I should be taken to the claimants details page

Scenario: Successfully submits required information only
  When I successfully submit the required respondents details only
  Then I should be taken to the claimants details page

Scenario: Displays required information error message
  When I click on next without providing the required respondents details
  Then I should see the error message saying the respondents details cant be blank