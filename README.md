[![Build Status](https://travis-ci.org/denmarkmeralpis/promotexter.svg?branch=master)](https://travis-ci.org/denmarkmeralpis/promotexter) [![Test Coverage](https://api.codeclimate.com/v1/badges/c20c43addcd61c8777f1/test_coverage)](https://codeclimate.com/github/denmarkmeralpis/promotexter/test_coverage) [![Maintainability](https://api.codeclimate.com/v1/badges/c20c43addcd61c8777f1/maintainability)](https://codeclimate.com/github/denmarkmeralpis/promotexter/maintainability) [![Gem Version](https://badge.fury.io/rb/promotexter.svg)](https://badge.fury.io/rb/promotexter)

Promotexter
======

A Ruby gem for consuming the [Promotexter API](http://promotexter.com/index.php/landing/developers) for sending mesages

## Requirements

  Ruby 2.x.x

## Installation

    $ gem install promotexter

 Or add it to your `Gemfile`:

  	gem promotexter

 Then generate initializer:

    $ rails g promotexter:install initializer

  then edit the file in `config/initializer/promotexter.rb` and supply the necessary details.

## Usage

Construct a Promotexter::Client object and use the #send_message method to
send a message. For example:

```ruby
require 'promotexter'

# send sms
client = Promotexter::Client.new
client.send_message(text: 'This is a test', to: '639171234567')

# or simply
Promotexter::Client.send_message(text: 'This is a test', to: '639171234567')

# or you can also pass the configurations as arguments
client = Promotexter::Client.new(api_key:'key', api_secret:'secret', sender_id:'xxxxxx')
client.send_message(text: 'This is a test', to:'639171234567')

# overriding of sender_id parameter from send_message
client = Promotexter::Client.new
client.send_message(text: 'Override sender_id on demand', to: '639171234567', sender_id: 'Sample')
```
If you want to use the delivery reports, head over to your initializer and uncomment the dlr_callback & dlr_reports lines

### Reports
```ruby
require 'promotexter'

# get account balance
Promotexter::Report.balance

# get sms transactions
reports = Promotexter::Report.new
reports.sms_transactions
```
Available filters:

Params | Required | Description
--- | --- | ---
after | No | Filter transactions with creation date greater than this value.
before | No | Filter transactions with creation date less than this value.
transaction_id | No | Specific transactionId lookup
reference_id | No | Specific referenceId lookup
category_id | No | Specific categoryId lookup
request_id | No | Specific requestId lookup
from | No | Filter transactions with creation date greater than or equal to this value.
to | No | Filter transactions with creation date less than or equal to this value.

example:

```ruby
reports = Promotexter::Report.new
reports.sms_transactions(from: '2018-10-03T14:44:23.186Z', to: '2018-11-03T14:44:23.186Z')

# or simply:
Promotexter::Report.sms_transactions(from: '2018-10-03T14:44:23.186Z', to: '2018-11-03T14:44:23.186Z')
```

## Production environment variables

Best practice for storing credentials for external services in production is
to use environment variables, as described by [12factor.net/config](http://12factor.net/config).
Promotexter::Client defaults to extracting the client_id, secret_key and shortcode it needs from the
PROMOTEXTER_API_KEY, PROMOTEXTER_API_SECRET and PROMOTEXTER_SENDER_ID environment variables if the
options were not specified explicitly.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Added awesome new features'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgement
Originally created by Nujian Den Mark Meralpis. Updated by Scrambled Eggs Software Inc.

Thanks to all [awesome contributors](https://github.com/denmarkmeralpis/promotexter/graphs/contributors). Cheers!


2016-2018
