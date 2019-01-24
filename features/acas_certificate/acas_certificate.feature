@javascript
Feature:
  As an ACAS administrator
  I want to download a certificate/document from the ET Admin
  So I can validate the certificate number and its contents
  And view logs detailing user access and error messages

  Scenario: Server error
   Given I am an ACAS administrator
   When I enter a 'server error' ACAS certificate number
   Then the system should return feedback from acas 'There was a problem with the ACAS service -  please try again later'
    
#    @manual
#   Scenario: No response from ACAS
#     Given I am an ACAS administrator
#     When I enter an ACAS certificate number in the ACAS search field
#     And an ACAS server is down for an unknown reason
#     Then the ET Admin should timeout after 3 seconds displaying 'Something has gone wrong, please try again later'

#   @manual
#   Scenario: ACAS AWS log
#     Given I am part of the devops team
#     When there is an error in our ACAS Admin section
#     Then I should be able to view AWS log which track ACAS error
