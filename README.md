# DaisyBill API
ActiveRecord Style Wrapper for DaisyBill's API

[![Build Status](https://semaphoreci.com/api/v1/projects/4e51c7d8-2ca3-4c3e-9172-ff2082309342/369271/shields_badge.svg)](https://semaphoreci.com/daisybill/daisybill_api)
[![Code Climate](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/badges/1cde64d9bdc572be43a9/gpa.svg)](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/feed)
[![Test Coverage](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/badges/1cde64d9bdc572be43a9/coverage.svg)](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/feed)

This gem is tested against the following versions of Ruby:
- 1.9.3
- 2.0.0
- 2.1.5
- 2.2.0

## Installation
*Not yet on ruby-gems*

```bash
gem install daisybill_api
```

```ruby
# Gemfile

gem 'daisybill_api'
```

## Usage
#### Available endpoints:
- Billing Providers (index, show)
- Rendering Providers (index, show, create, update)
- Referring Providers (index, show, create, update)
- Places of Service (index, show, create, update)
- Patients (index, show, create, update, destroy)
- Injuries (index, show, create, update, destroy)
- Bills (index, show, create, update, destroy)
- Attachments (index, show, create, update, destroy)
- Bill Submissions (index, show, create)
- Bill Payments (index)

```ruby
DaisybillApi.configuration.api_token = 'API_TOKEN'

# List Billing Providers
DaisybillApi::Models::BillingProvider.all

# Get specific Billing Provider
DaisybillApi::Models::BillingProvider.find(14)

# List of Rendering Providers for Billing Provider
billing_provider = DaisybillApi::Models::BillingProvider.find(14)
billing_provider.rendering_providers

# List of Places of Service for Billing Provider
billing_provider = DaisybillApi::Models::BillingProvider.find(14)
billing_provider.places_of_service

# List Patients for Billing Provider
billing_provider = DaisybillApi::Models::BillingProvider.find(14)
billing_provider.patients

# Create Patient
address = DaisybillApi::Models::Address.new(
  address_1: "1 Main Street",
  address_2: "Apt 3C",
  city: "Los Angeles",
  state: "CA",
  zip_code: "90001"
)

pt = DaisybillApi::Models::Patient.new(
  billing_provider_id: 14,
  first_name: "Johnny",
  last_name: "Smith",
  address: address,
  ssn: "123456789",
  gender: "Male"
)

pt.save
=> true

# inspect errors
pt = DaisybillApi::Models::Patient.new(billing_provider_id: 14, first_name: "Johnny")
pt.save
pt.errors.full_messages
=> ["Last name can't be blank"]

# Get list of injuries for a patient
patient = DaisybillApi::Models::Patient.find(345)
patient.injuries

# Create Injury
injury = DaisybillApi::Models::Injury.new(patient_id: 345, description: 'Broken Arm', claim_number: '1234567')
injury.save

# List of Bills for an Injury
injury = DaisybillApi::Models::Injury.find(333)
injury.bills

# Get a specific Bill
DaisybillApi::Models::Bill.find(345)

# Create Bill
bp = DaisybillApi::Models::BillingProvider.find(14)
pos = bp.places_of_service.first
rp = bp.rendering_providers.first

sli = DaisybillApi::Models::ServiceLineItem.new(
  procedure_code: "S9981",
  units: 1,
  modifier_codes: ["93", "17"],
  diagnosis_code_1: "72700",
  custom_unit_charge_cents: 12345
)

bill = DaisybillApi::Models::Bill.new(
  injury_id: 345,
  date_of_service: '2015-01-01',
  rendering_provider_id: rp.id,
  place_of_service_id: pos.id,
  diagnosis_codes: ["72700"],
  service_line_items: [sli]
)

bill.save

# Create Bill Submission for Bill
bill = DaisybillApi::Models::Bill.find(386315)
bill_submission = DaisybillApi::Models::BillSubmission.new(bill_id: bill.id)
bill_submission.create

# Get list of bill payments for bill
bill = DaisybillApi::Bill.find(1)
bp = bill.bill_payments.first

# Create attachment for Bill
DaisybillApi::Models::Attachment.create(
  bill_id: 5600,
  report_type: "09",
  document: File.open("path/to/file")
)

# Destroy Bill
bill.destroy
```

# Pagination

`Model.all` returns a `PageableCollection` object which includes enumberable.

```ruby
@page = injury.bills

@page.first_page
@page.last_page
@page.next_page
@page.previous_page

until @page.next_page.nil? do
  puts @page.map(&:id)
  @page = @page.next_page
end
```

## Contributing
1. Fork the project.
2. Create a topic branch and preface with issue number if available. E.g, `4_undefined_method_name_for_nil_class`
3. Implement feature or bug fix
4. If specs were not added in step 3, add then now.
5. Run `bundle exec rspec spec`.
6. Commit and push your changes.
7. Submit a pull request. Please do not include changes to the gemspec or version file.

## License
*This project uses the MIT-LICENSE.*

