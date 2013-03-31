```ruby
x = Xeroid.new(private_client)
x.invoices.post_one(Xeroid::Objects::Invoice.new(...))
x.invoices.post_many([Xeroid::Objects::Invoice.new(...)])
x.invoices.fetch(<Xeroid::Objects::Invoice>)
x.invoices.all()
x.invoices.put_one(...)
x.invoices.put_many(...)
x.invoices.where().modified_after()
```

Attachments
https://api.xero.com/api.xro/2.0/{Endpoint}/{Guid}/Attachments
GET, PUT, POST
GET https://api.xero.com/api.xro/2.0/{Endpoint}/{Guid}/Attachments/
GET https://api.xero.com/api.xro/2.0/{Endpoint}/{Guid}/Attachments/{Filename}
POST extras: https://api.xero.com/api.xro/2.0/{Endpoint}/{Guid}/Attachments/{Filename}

Accounts
https://api.xero.com/api.xro/2.0/Accounts
GET
AccountID, Modified After, where, order

BankStatements

BankTransactions
https://api.xero.com/api.xro/2.0/BankTransactions
GET, PUT, POST
InvoiceID, Modified After, where, order

Branding Themes
https://api.xero.com/api.xro/2.0/BrandingThemes
GET

Contacts
https://api.xero.com/api.xro/2.0/Contacts
POST, PUT, GET
ContactID, ContactNumber, Modified After, where, order

Credit Notes
https://api.xero.com/api.xro/2.0/CreditNotes
POST, PUT, GET
CreditNoteID, CreditNoteNumber, Modified After, where, order

Currencies
https://api.xero.com/api.xro/2.0/Currencies
GET
Modified After, where, order

Employees
https://api.xero.com/api.xro/2.0/Employees
POST, PUT, GET
EmployeeID, Modified After, where, order

Expense Claims
https://api.xero.com/api.xro/2.0/ExpenseClaims
GET, PUT, POST
ExpenseClaimID, Modified After, where, order

Invoices
https://api.xero.com/api.xro/2.0/Invoices
GET, PUT, POST
InvoiceID, InvoiceNumber, Modified After, where, order

Items
https://api.xero.com/api.xro/2.0/Items
GET, PUT, POST
ItemID, Code, Modified After, where, order

Journals
https://api.xero.com/api.xro/2.0/Journals
GET
JournalID, JournalNumber, Modified After, where, order

Manual Journals
https://api.xero.com/api.xro/2.0/ManualJournals
GET, PUT, POST
JournalID, Modified After, where, order

Organisation
https://api.xero.com/api.xro/2.0/Organisation
GET

Payments
https://api.xero.com/api.xro/2.0/Payments
GET, PUT
PaymentID, Modified After, where, order

Receipts
https://api.xero.com/api.xro/2.0/Receipts
GET, PUT, POST
ReceiptID, Modified After; where; order
Reports

Tax Rates
https://api.xero.com/api.xro/2.0/TaxRates
GET
TaxType; where; order

Tracking Categories
https://api.xero.com/api.xro/2.0/TrackingCategories
GET
TrackingCategoryID; where; order
Types

Users
https://api.xero.com/api.xro/2.0/Users
GET
Attachments
UserID; Modified After; where; order
