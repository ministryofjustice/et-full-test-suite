@javascript
Feature: Create new user
  As an Admin/Super user
  I want to be able to add, edit and delete users who are no longer working for MOJ

  Background: 
    When an administrator login
    And load User page

  #Typical day-to-day ET Admin functions e.g Acas certificate and view office postcodes
  Scenario: New user with User role permissions
    When a new user is created with 'User' role
    Then they should be able to login
    And have basic access to ET admin system

  #Allow viewing of the submitted Claim and Response forms and to maintain Office Postcode coverage definitions
  Scenario: New user with Super User role permission
    When a new user is created with 'Super User' role 
    Then they should be able to login
    And have partial access to ET system

 #Provide access to all ET admin functions including add/remove users and user role maintenance
  Scenario: New user with Admin role permissions
    When a new user is created with 'Admin' role
    Then they should be able to login
    And have full access to ET admin system

  Scenario: Import users via csv file
    And import 'dummy.test' users
    Then users have successfully been imported