@et3 @javascript 

Feature: Confirmation of supplied details page

Background: ET3 confirmation of supplied details page
  Given I am on the ET3 confirmation of supplied details page

Scenario: Successfully submits my form
  When I submit my form
  Then I am taken to the form submission page

Scenario: Displays my answers
 Then I should see my answers to the questions

Scenario: Changing my answers
  When I change my answer on the employer contract form page
  Then I should see my updated answer on the confirmation of supplied details page

Scenario: Displays back to the top
  Then I should see each page section has a back to top link

Scenario: Back to the top
  When I click on back to the top
  Then I should be taken to the top of the confirmation of supplied details page
 