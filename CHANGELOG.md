# Changelog

## Unreleased
- Add `bill.tasks`                                        [PR](https://github.com/daisybill/daisybill_api/pull/103)
- Add `Task` resource                                     [PR](https://github.com/daisybill/daisybill_api/pull/103)
- Add `claims_administrator.bill_mailing_addresses`       [PR](https://github.com/daisybill/daisybill_api/pull/99)
- Add `payer.bill_mailing_addresses`                      [PR](https://github.com/daisybill/daisybill_api/pull/99)
- Add `bill_payment.claim_adjustment_reasons`             [PR](https://github.com/daisybill/daisybill_api/pull/100)
- Add `bill_payment.service_line_item_payments`           [PR](https://github.com/daisybill/daisybill_api/pull/100)
- Add `BillPayment` `find` method                         [PR](https://github.com/daisybill/daisybill_api/pull/104)
- Add `User` resource                                     [PR](https://github.com/daisybill/daisybill_api/pull/105)
- Add `practice_bill_id` to pharmacy bills                [PR](https://github.com/daisybill/daisybill_api/pull/96)
- Add ability to create/update contacts                   [PR](https://github.com/daisybill/daisybill_api/pull/95)
- Add support for receiving 405 responses                 [PR](https://github.com/daisybill/daisybill_api/pull/93)
- Add ability to view review warnings for certain models  [PR](https://github.com/daisybill/daisybill_api/pull/92)
- Add ability to create and view error reports for a bill [PR](https://github.com/daisybill/daisybill_api/pull/84)
- Add ability to set telephone for places of service      [PR](https://github.com/daisybill/daisybill_api/pull/87)

## [0.1.4] - January 30th, 2017
- Add ability to set `comment`, `supporting_document_ids` on bill submissions
- Drop support for Ruby 2.1.5 and lower

## [0.1.3] - January 25th, 2017
- Add ability to get injuries for billing provider [PR](https://github.com/daisybill/daisybill_api/pull/74)
- Add ability to get bills for billing provider [PR](https://github.com/daisybill/daisybill_api/pull/73)
- Add `RequestForSecondReview` and `DisputedService` resources - [PR](https://github.com/daisybill/daisybill_api/pull/72)
- Add `Remittance` resource - [PR](https://github.com/daisybill/daisybill_api/pull/70)
- Add `ClaimNumberVerification` resource - [PR](https://github.com/daisybill/daisybill_api/pull/69)
- Add `Payer` and `ClaimsAdministrator` `find` methods - [PR](https://github.com/daisybill/daisybill_api/pull/67)
- Add `PrescribingProvider` resource - [PR](https://github.com/daisybill/daisybill_api/pull/67)
- Add `PharmacyBill` resource - [PR](https://github.com/daisybill/daisybill_api/pull/65)

## [0.1.2] - October 18th, 2016
- Add rails 5 support - [PR](https://github.com/daisybill/daisybill_api/pull/64)
- `DaisybillApi::Data::Client::BasicError` now inherits from `StandardError` - [PR](https://github.com/daisybill/daisybill_api/pull/62)
- Add ability to assign payers to injuries - [PR](https://github.com/daisybill/daisybill_api/pull/55)

## [0.1.1] - April 11th, 2016
- Add missing `Attachment` attributes - [PR](https://github.com/daisybill/daisybill_api/pull/46)
- Add `description` to `ClaimsAdministrator` - [PR](https://github.com/daisybill/daisybill_api/pull/53)
- Add `Payer` resource - [PR](https://github.com/daisybill/daisybill_api/pull/52)
- Add `_destroy` attribute for `ServiceLineItem` - [PR](https://github.com/daisybill/daisybill_api/pull/50)
- Add `Patient` search [PR](https://github.com/daisybill/daisybill_api/pull/48)
- Add `BillingProvider` attachments [PR](https://github.com/daisybill/daisybill_api/pull/47)

## [0.1.0] - October 26, 2015
- Open-source gem
