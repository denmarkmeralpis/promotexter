require 'dotenv'
Dotenv.load

RSpec.describe Promotxter do
  it "has a version number" do
    expect(Promotxter::VERSION).not_to be nil
  end

  context "when initializing a request" do
    it "should have an API key" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing'})
      expect(client.api_key).to eq ENV['PROMOTXTER_API_KEY']
    end

    it "should have an API secret" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing'})
      expect(client.api_secret).to eq ENV['PROMOTXTER_API_SECRET']
    end

    it "should have a sender id" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing'})
      expect(client.from).to eq ENV['PROMOTXTER_FROM']
    end
  end

end
