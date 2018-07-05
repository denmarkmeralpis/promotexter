require 'dotenv'

RECEIVING_NUMBER = '639369642045'


RSpec.describe Promotxter do
  it "has a version number" do
    expect(Promotxter::VERSION).not_to be nil
  end

  context "when initializing a request" do
    it "should have an API key" do
      client = Promotxter::Client.new(apiKey: ENV['PROMOTXTER_API_KEY'], apiSecret: ENV['PROMOTXTER_API_SECRET'], from: 'PROMOTXTER_FROM')
      response = client.send_message({to: RECEIVING_NUMBER, text: 'testing'})
      expect(client.apiKey).to eq ENV['PROMOTXTER_API_KEY']
    end

    it "should have an API secret" do
      client = Promotxter::Client.new(apiKey: ENV['PROMOTXTER_API_KEY'], apiSecret: ENV['PROMOTXTER_API_SECRET'], from: 'PROMOTXTER_FROM')
      response = client.send_message({to: RECEIVING_NUMBER, text: 'testing'})
      expect(client.apiSecret).to eq ENV['PROMOTXTER_API_SECRET']
    end

    it "should have a sender id" do
      client = Promotxter::Client.new(apiKey: ENV['PROMOTXTER_API_KEY'], apiSecret: ENV['PROMOTXTER_API_SECRET'], from: 'PROMOTXTER_FROM')
      response = client.send_message({to: RECEIVING_NUMBER, text: 'testing'})
      expect(client.from).to eq ENV['PROMOTXTER_FROM']
    end
  end

end
