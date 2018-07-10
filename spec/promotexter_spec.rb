require 'webmock/rspec'
require 'dotenv'
require 'json'
Dotenv.load

RSpec.describe Promotexter do
  let(:client) {Promotexter::Client.new(api_key: ENV['PROMOTEXTER_API_KEY'], api_secret: ENV['PROMOTEXTER_API_SECRET'], from: ENV['PROMOTEXTER_FROM'])}
  before do
    res_body = '{"apiKey": "key", "apiSecret": "secret", "from": "DEMO", "text": "testing2", "to": "639369642045"}'
    stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: res_body, status: 200, headers: {})  
  end


  it 'has a version number' do
    expect(Promotexter::VERSION).not_to be nil
  end

  context 'when initializing a request' do
    it 'should have an API key' do
      expect(client.api_key).to eq ENV['PROMOTEXTER_API_KEY']
    end

    it 'should have an API secret' do
      expect(client.api_secret).to eq ENV['PROMOTEXTER_API_SECRET']
    end

    it 'should have a sender id' do
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(client.from).to eq ENV['PROMOTEXTER_FROM'] 
    end
  end

  context 'when sending a message' do
    it 'should have an ok status' do
      success_response = '{"status": "ok", "data": {"id": "jhlfahf001", "unitCost": "0.50", "messageParts": "1", "transactionCost": "0.50", "remaining": "200", "from": "DEMO", "to": "639369642045", "operatorCode": "flabfldblahlgh", "source": "119.93.251.124"}}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: success_response, status: 200, headers: {})
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:status]).to eq 'ok'
    end
  end

  context 'when receiving a success json response from send endpoint' do
    it 'should have a data object from json' do
      success_response = '{"status": "ok", "data": {"id": "jhlfahf001", "unitCost": "0.50", "messageParts": "1", "transactionCost": "0.50", "remaining": "200", "from": "DEMO", "to": "639369642045", "operatorCode": "flabfldblahlgh", "source": "119.93.251.124"}}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: success_response, status: 200, headers: {})
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response.has_key?(:data)).to eq true
      expect(response[:data]).not_to eq nil
    end

    it 'should have a message id from json' do
      success_response = '{"status": "ok", "data": {"id": "jhlfahf001", "unitCost": "0.50", "messageParts": "1", "transactionCost": "0.50", "remaining": "200", "from": "DEMO", "to": "639369642045", "operatorCode": "flabfldblahlgh", "source": "119.93.251.124"}}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: success_response, status: 200, headers: {})
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:data].has_key?(:id)).to eq true
      expect(response[:data][:id]).not_to eq nil
    end

    it 'should have a message source from json' do
      success_response = '{"status": "ok", "data": {"id": "jhlfahf001", "unitCost": "0.50", "messageParts": "1", "transactionCost": "0.50", "remaining": "200", "from": "DEMO", "to": "639369642045", "operatorCode": "flabfldblahlgh", "source": "119.93.251.124"}}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: success_response, status: 200, headers: {})
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:data].has_key?(:source)).to eq true
      expect(response[:data][:source]).not_to eq nil
    end

    it 'should have a receiving number' do
      success_response = '{"status": "ok", "data": {"id": "jhlfahf001", "unitCost": "0.50", "messageParts": "1", "transactionCost": "0.50", "remaining": "200", "from": "DEMO", "to": "639369642045", "operatorCode": "flabfldblahlgh", "source": "119.93.251.124"}}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_return(body: success_response, status: 200, headers: {})
      response = client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'})
      expect(response[:data].has_key?(:to)).to eq true
      expect(response[:data][:to]).not_to eq nil
    end
  end
  
  context 'when receiving a failed json response' do
    it 'raise an error' do
      error_response = '{"statusCode": 400, "error": "BadRequestError", "message": "Missing Parameter"}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_raise(Promotexter::BadRequestError)
      expect { client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'}) }.to raise_error(Promotexter::BadRequestError)
    end
  end

  context 'when given an invalid sender id' do
    it 'should return an invalid senderId error message' do
      error_response = '{"statusCode": 400, "error": "BadRequestError", "message": "Invalid SenderID"}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_raise(Promotexter::BadRequestError)
      expect { client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'}) }.to raise_error(Promotexter::BadRequestError)
      expect { raise Promotexter::BadRequestError, 'Invalid SenderID' }.to raise_error('Invalid SenderID')
    end
  end

  context 'when given incomplete parameters' do
    it 'should return a mmissing parameter error message' do
      error_response = '{"statusCode": 400, "error": "BadRequestError", "message": "Missing Parameter"}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_raise(Promotexter::BadRequestError)
      expect { client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'}) }.to raise_error(Promotexter::BadRequestError)
      expect { raise Promotexter::BadRequestError, 'Missing Parameter' }.to raise_error('Missing Parameter')
    end
  end

  context 'when given an invalid mobile number' do
    it 'should return an invalid mobile number error message' do
      error_response = '{"statusCode": 400, "error": "BadRequestError", "message": "Invalid mobile number"}'
      stub_request(:post, "https://rest-portal.promotexter.com/sms/send").to_raise(Promotexter::BadRequestError)
      expect { client.send_message({to: ENV['RECEIVING_NUMBER'], text: 'testing2'}) }.to raise_error(Promotexter::BadRequestError)
      expect { raise Promotexter::BadRequestError, 'Invalid mobile number' }.to raise_error('Invalid mobile number')
    end
  end
end
