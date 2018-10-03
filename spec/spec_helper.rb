require 'bundler/setup'
require 'promotexter'
require 'webmock/rspec'
require 'simplecov'
require 'simplecov-console'
require 'dotenv'
require 'byebug'

Dotenv.load

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Promotexter.configure do |promotexter_config|
      promotexter_config.api_secret = ENV['PROMOTEXTER_API_SECRET']
      promotexter_config.api_key    = ENV['PROMOTEXTER_API_KEY']
      promotexter_config.sender_id  = ENV['PROMOTEXTER_SENDER_ID']
    end
  end
end

def response_body(file_name)
  File.read(File.expand_path('../support/fixtures/' + file_name, __FILE__))
end
