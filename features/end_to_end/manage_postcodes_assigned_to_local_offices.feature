@e2e
@javascript
Feature: Manage postcodes assigned to local offices
  As a Super or Admin user
  I want to manage the postcodes assigned to local offices
  So that applications continue to be sent to the right office

  Background: 
    Given an administrator login

  Scenario: Add new postcode
    When a new postcode 'TT' is added to 'Default' office
    Then the new postcode is saved on the system

  Scenario: Assign postcode to a different office
    Given a postcode 'TT' is assigned to 'Default' office
    When I reassign the postcode to 'Southampton' office
    Then the postcode will be assigned to the different office and no longer assigned to the original office

  Scenario: Delete existing postcode
    Given an existing postcode 'TT' is assigned to 'Default' office
    When I delete postcode 'TT'
    Then the deleted postcode is no longer saved in the system

  Scenario: Filename based on newly added postcode 'BT' to 'Default' office
    Given a new postcode 'BT' is added to 'Default' office
    When a claimant submitted an ET1 form using postcode 'BT1 1AA'
    And I can download the form from the secondary queue and that the filename starts with '99'
