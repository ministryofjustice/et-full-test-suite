# This test can only be run in production
# @e2e
# @javascript
# Feature:
#   As an ATOS migration team
#   I want to be sure that the completed ET files are being sent to the right office
#   So I can triage an employees claim against their employer

#   Scenario: M3 2JA - manchester
#     Given claimant home postcode 'M3 2JA' then submission office will be 'Manchester, Alexandra House, 14-22 The Parsonage, Manchester M3 2JA'
#     When the completed form is submitted

#   Scenario: G2 7TS - Glasgow
#     Given claimant work postcode 'G2 7TS' then submission office will be 'Glasgow, Eagle Building, 215 Bothwell Street, Glasgow, G2 7TS'
#     When the completed form is submitted

#   Scenario: LS6 1BY - Leeds
#     Given claimant work postcode 'LS6 1BY' then submission office will be 'Leeds, 4th Floor, City Exchange, 11 Albion Street, Leeds LS1 5ES'
#     When the completed form is submitted

#   Scenario: B1 1BY - Birmingham
#     Given claimant work postcode 'B1 1BY' then submission office will be 'Midlands (West) ET, Centre City Tower, 5-7 Hill Street, Birmingham B5 4UU'
#     When the completed form is submitted

#   Scenario: Case number starting with 24 will be forwarded to Manchester
#     Given an employer responds to a claim with case number starting '2454321/2017'
#     When the completed Employment Tribunal response form is submitted
#     Then it will be forwarded to the Office address 'Alexandra House, 14-22 The Parsonage, Manchester M3 2JA'
#     And phone number 'Telephone 0161 833 6100'

#   Scenario: Case number starting with 18 will be forwarded to the Default Office
#     Given an employer responds to a claim with case number starting '1854321/2017'
#     When the completed Employment Tribunal response form is submitted
#     Then it will be forwarded to the Office address '4th Floor, City Exchange, 11 Albion Street, Leeds LS1 5ES'
#     And phone number 'Telephone 0113 245 9741'