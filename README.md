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

## Usage

Construct a Promotexter::Client object and use the #send_message method to
send a message. For example:

```ruby
require 'promotexter'

client = Promotexter::Client.new(api_key:'key', api_secret:'secret', from:'xxxxxx')
client.send_message(message:'This is a test', to:'639171234567')
```

## Production environment variables

Best practice for storing credentials for external services in production is
to use environment variables, as described by [12factor.net/config](http://12factor.net/config).
Promotexter::Client defaults to extracting the client_id, secret_key and shortcode it needs from the
PROMOTEXTER_API_KEY, PROMOTEXTER_API_SECRET and PROMOTEXTER_FROM environment variables if the
options were not specified explicitly.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Added awesome new features'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request
6. ???
7. Profit

## MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgement
Originally created by Nujian Den Mark Meralpis, Updated by Scrambled Eggs Software Inc.

2016-2018