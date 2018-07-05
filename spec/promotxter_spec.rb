require 'dotenv'
Dotenv.load

RSpec.describe Promotxter do
  it "has a version number" do
    expect(Promotxter::VERSION).not_to be nil
  end

  context "when initializing a request" do
    it "should have an API key" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      expect(client.api_key).to eq ENV['PROMOTXTER_API_KEY']
    end

    it "should have an API secret" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      expect(client.api_secret).to eq ENV['PROMOTXTER_API_SECRET']
    end

    it "should have a sender id" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(client.from).to eq ENV['PROMOTXTER_FROM']
      expect(response.from).to eq ENV['PROMOTXTER_FROM']
    end
  end

  context "when sending a message" do
    # it "return a 200 status" do
    #   client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: 'PROMOTXTER_FROM')
    #   response = client.send_message({to: ENV[RECEIVING_NUMBER, text: 'testing2']})
    #   expect(response).to have_http_status(200)
    # end

    it "should have an 'ok' status" do
      client = Promotxter::Client.new(api_key: ENV['PROMOTXTER_API_KEY'], api_secret: ENV['PROMOTXTER_API_SECRET'], from: ENV['PROMOTXTER_FROM'])
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response.status).to eq 'ok'
    end
  end
end
