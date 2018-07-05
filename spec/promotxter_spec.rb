RSpec.describe Promotxter do
  it "has a version number" do
    expect(Promotxter::VERSION).not_to be nil
  end

  context "Client" do

  	context "when initializing a request" do
    it "should have an API key and an API secret variable" do
      client = Promotxter::Client.new({apiKey: 'hfdkjsagkjgsajkgjk', apiSecret: 'sampleapikeysdfhfsht', from: 'DEMO'})
      response = client.send_message({to: '639369642045', text: 'testing'})
      expect(client.apiKey).to eq "hfdkjsagkjgsajkgjk"
      expect(client.apiSecret).to eq "sampleapikeysdfhfsht"
    end
  end

  	it "must be able to send a message" do
  		client = Promotxter::Client.new()
  		response = client.send_message({ to: '639175018430', text: 'testing' })
  		expect(response["status"]).should eq "ok"
  		expect(response["message"]["to"]).should eq '639175018430'
  	end
	end
end
