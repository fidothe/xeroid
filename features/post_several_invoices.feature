Feature: Posting a single invoice
  As a user of the Xero API
  I want to post several invoices to Xero in a single batch
  In order to get them into Xero as quickly as possible

  @wip
  @vcr
  Scenario: Posting new, minimal, draft invoices
    Given several valid minimal draft invoice objects
    When I post them to Xero
    Then I should get confirmation they were posted successfully
      And get back invoice objects with IDs

