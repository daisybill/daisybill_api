# DaisyBill API
ActiveRecord Style Wrapper for DaisyBill's API

[![Build Status](https://semaphoreci.com/api/v1/projects/4e51c7d8-2ca3-4c3e-9172-ff2082309342/369271/shields_badge.svg)](https://semaphoreci.com/daisybill/daisybill_api)
[![Code Climate](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/badges/1cde64d9bdc572be43a9/gpa.svg)](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/feed)
[![Test Coverage](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/badges/1cde64d9bdc572be43a9/coverage.svg)](https://codeclimate.com/repos/54ff0165e30ba055fa001c7f/feed)

Full documentation of the api is available [here](api.daisybill.com)

## Installation
```bash
gem install daisybill_api
```

Or in rails

```ruby
# Gemfile

gem 'daisybill_api'
```

## Usage
#### Available endpoints:
- Billing Providers
- Rendering Providers
- Referring Providers
- Places of Service
- Patients
- Injuries
- Bills
- Attachments

```ruby
DaisybillAPI.token = 'API_TOKEN'

# List Billing Providers
DaisybillApi::BillingProvider.all

# Get specific Billing Provider
DaisybillApi::BillingProvider.find('1')

# List of Rendering Providers for Billing Provider
billing_provider = DaisybillApi::BillingProvider.find('1')
billing_provdier.rendering_providers

# Create Patient
DaisybillApi::Patient.create(billing_provider_id: 1, first_name: "Johnny", last_name: "Apple")

# Get list of injuries for a patient
patient = DaisybillApi::Patient.find('1')
patient.injuries

# Create Injury
DaisybillApi::Injury.create(patient_id: 1, description: 'Broken Arm', claim_number: '1234567')

# List of Bills for an Injury
injury = DaisybillApi::Injury.find('1')
injury.bills

# Create Bill
DaisybillApi::Bill.create(injury_id: 1, date_of_service: '2015-01-01', rendering_provider_id: 1, place_of_service_id: 1)

# Get a specific Bill
DaisybillApi::Bill.find('1')
```

## Contributing
1. Fork the project.
2. Create a topic branch and preface with issue number if available. E.g, `4_undefined_method_name_for_nil_class`
3. Implement feature or bug fix.
4. Add documentation for your feature or bug fix.
5. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run `bundle exec rake spec`. If your changes are not 100% covered, please go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec or version.

## License
*This project uses the MIT-LICENSE.*

