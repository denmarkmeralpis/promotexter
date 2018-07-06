require 'webmock/rspec'
require 'dotenv'
Dotenv.load

# stub_request(:post, "https://rest-portal.promotexter.com").
#     with(:headers => { 'Content-Type' => 'application/json' }).to_return(:body => "abc")

# #Actual request
# req = Net::HTTP::Post.new('/')
# req['Content-Length'] = 3
# Net::HTTP.start('http://www.google.com/', 80) {|http|
#     http.request(req, 'abc')
# }    # ===> Success

# request(:post, "www.google.com").
#   with(:body => "abc", :headers => { 'Content-Length' => 3 }).should have_been_made.once

# request(:get, "www.something.com").should_not have_been_made    # ===> Success

RSpec.describe Promotxter do
  it 'has a version number' do
    expect(Promotxter::VERSION).not_to be nil
  end

  context 'when initializing a request' do
    it 'should have an API key' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      expect(client.api_key).to eq ENV['PROMOTXTER_API_KEY']
    end

    it 'should have an API secret' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      expect(client.api_secret).to eq ENV['PROMOTXTER_API_SECRET']
    end

    it 'should have a sender id' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(client.from).to eq ENV['PROMOTXTER_FROM']
      expect(response[:data][:from]).to eq ENV['PROMOTXTER_FROM']
    end
  end

  context 'when sending a message' do
    it 'should have an ok status' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:status]).to eq 'ok'
    end
  end

  context 'when given an invalid sender id' do
    it 'should return an invalid senderId error message' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: 'sender')
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:message]).to eq 'Invalid SenderID'
    end

    it 'should return a 400 status code' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: 'sender')
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      puts response[:statusCode]
      expect(response[:statusCode]).to eq 400
    end
  end

  context 'when receiving a success json response from send endpoint' do
    it 'should have a message object from json' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: 'sender')
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response.has_key('message')).to eq true
      expect(response[:message]).not_to eq nil
    end

    it 'should have a message id from json' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: 'sender')
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:message][:id]).not_to eq nil
    end

    it 'should have a message source from json' do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(client.from).to eq ENV['PROMOTXTER_FROM']
      # expect(response[:data][:source]).to
    end
    #TODO: add more fields to check
  end

  context 'when receiving a failed json response from send endpoint' do
    it 'should have a statusCode field from json' do
      #TODO: add expectations here
    end

    #TODO: add more fields to check
  end
end
