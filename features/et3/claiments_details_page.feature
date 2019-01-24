@et3 @javascript

Feature: Claimants details page

Background: ET3 claimants details page
  Given I am on the ET3 claimants details page

Scenario: Verify Claimants details copy
    Then Claimants details page copy texts are displayed in the correct language

Scenario: Successfully submits all the claimants details
  When I successfully submit all the claimants details
  Then I should be taken to the earnings and benefits page

Scenario: Successfully submits required claimants details only
  When I successfully submit required claimants details only
  Then I should be taken to the earnings and benefits page

Scenario: Displays required information error message
  When I click on next without providing the required claimants details
  Then I should see the error message saying the claimants details cant be blank

Scenario: Dates given by the claimant error message
  When I select no to are the dates given by the claimant correct
  But I do not provide the correct employment dates or give a reason
  Then I should see the error message saying the further information about dates cant be blank