@wip @javascript

Feature: Response page

Background: ET3 response page
  Given I am on the ET3 response page

Scenario: Successfully submits my response
  When I successfully submit my response
  Then I should be taken to your representative page

Scenario: Displays response to claim error message
  When I try to continue without providing a response to claim question
  Then I should see the error message saying the response to claim cant be blank
