Feature: Creating a Contact
  As a user of Xero API
  I want to post a contact to Xero
  In order to get it into Xero

  @vcr
  Scenario: Posting a new contact
    Given a valid contact object
    When I post it to Xero
    Then I should get confirmation it was posted successfully
      And get back a contact object with ID

