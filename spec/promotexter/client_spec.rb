require_relative '../spec_helper'

RSpec.describe Promotexter::Client do
  let(:host)   { 'https://rest-portal.promotexter.com/api/sms' }
  let(:client) { Promotexter::Client.new }

  before do
    Promotexter.configure do |config|
      config.api_key = ENV['PROMOTEXTER_API_KEY']
      config.api_secret = ENV['PROMOTEXTER_API_SECRET']
      config.sender_id  = ENV['PROMOTEXTER_SENDER_ID']
    end
  end

  context '#initialize' do
    it { expect(Promotexter::Client.new).to be_an_instance_of(Promotexter::Client) }
  end

  context '#send_message' do
    context 'with configuration block as arguments' do
      let(:client_with_config) do
        Promotexter::Client.new(api_key: ENV['PROMOTEXTER_API_KEY'],
                                api_secret: ENV['PROMOTEXTER_API_SECRET'],
                                sender_id: ENV['PROMOTEXTER_SENDER_ID'])
      end
      it 'should have API key' do
        expect(client_with_config.api_key).to eq(ENV['PROMOTEXTER_API_KEY'])
      end

      it 'should have API secret' do
        expect(client_with_config.api_secret).to eq(ENV['PROMOTEXTER_API_SECRET'])
      end

      it 'should have sender ID' do
        expect(client_with_config.sender_id).to eq(ENV['PROMOTEXTER_SENDER_ID'])
      end
    end

    context 'sending a valid configuration and parameters' do
      it 'should have a success response' do
        stub_request(:post, host).to_return(body: response_body('success.json'), status: 200, headers: {})
        response = client.send_message(text: 'hello world', to: ENV['RECEIVING_NUMBER'])

        expect(client.sender_id).to eq(ENV['PROMOTEXTER_SENDER_ID'])
        expect(client.api_key).to eq(ENV['PROMOTEXTER_API_KEY'])
        expect(client.api_secret).to eq(ENV['PROMOTEXTER_API_SECRET'])

        expect(response).to be_truthy
        expect(response).to have_key(:id)
        expect(response).to have_key(:from)
        expect(response).to have_key(:to)
      end
    end

    context 'when sending invalid data' do
      it 'should have an error response' do
        stub_request(:post, host).to_return(body: response_body('error.json'), status: 422, headers: {})
        expect { client.send_message(to: 'invalid-mobile-format', text: 'hello world') }.to raise_error(Promotexter::Errors::BadRequest)
      end
    end

    context 'when given an invalid sender id' do
      it 'should return an invalid senderId error message' do
        stub_request(:post, host).to_raise(Promotexter::Errors::BadRequest)
        expect { client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world') }.to raise_error(Promotexter::Errors::BadRequest)
        expect { raise Promotexter::Errors::BadRequest, 'The sender is invalid.' }.to raise_error('The sender is invalid.')
      end
    end

    context 'when given incomplete parameters' do
      it 'should return a mmissing parameter error message' do
        stub_request(:post, host).to_raise(Promotexter::Errors::BadRequest)
        expect { client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world') }.to raise_error(Promotexter::Errors::BadRequest)
        expect { raise Promotexter::Errors::BadRequest, 'Parameters validation error.' }.to raise_error('Parameters validation error.')
      end
    end

    context 'when given an invalid mobile number' do
      it 'should return an invalid mobile number error message' do
        stub_request(:post, host).to_raise(Promotexter::Errors::BadRequest)
        expect { client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world') }.to raise_error(Promotexter::Errors::BadRequest)
        expect { raise Promotexter::Errors::BadRequest, 'The recipient is invalid.' }.to raise_error('The recipient is invalid.')
      end
    end

    context 'when given an invalid api key/secret' do
      it 'should return unauthorized error message' do
        stub_request(:post, host).to_raise(Promotexter::Errors::Authentication)
        expect { client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world') }.to raise_error(Promotexter::Errors::Authentication)
        expect { raise Promotexter::Errors::Authentication, 'Unauthorized Access.' }.to raise_error('Unauthorized Access.')
      end
    end

    context 'when configuration contains delivery report' do
      before do
        Promotexter.configuration.dlr_report = 1
        Promotexter.configuration.dlr_callback = 'http://example.com'
      end

      it 'should return a valid dlr report config' do
        expect(Promotexter.configuration.dlr_report).to eq(1)
        expect(Promotexter.configuration.dlr_callback).to eq('http://example.com')
      end
    end

    context 'when dlr configuration is invalid' do
      before do
        Promotexter.configuration.dlr_report = 1
        Promotexter.configuration.dlr_callback = 'invalid dlr callback'
      end

      it 'should raise bad request error' do
        stub_request(:post, host).to_raise(Promotexter::Errors::BadRequest)
        expect { client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world') }.to raise_error(Promotexter::Errors::BadRequest)
        expect { raise Promotexter::Errors::BadRequest, 'The callback is invalid.' }.to raise_error('The callback is invalid.')
      end
    end

    context 'when async config is set' do
      before { Promotexter.configuration.async = 1 }

      it 'should return requestId only' do
        stub_request(:post, host).to_return(body: '{"requestId": "ad0b6c91-de93-4dac-9d2f-e40fd746d81b"}', status: 200)
        response = client.send_message(to: ENV['RECEIVING_NUMBER'], text: 'hello world')

        expect(Promotexter.configuration.async).to eq(1)
        expect(response).to have_key(:requestId)
        expect(response).not_to have_key(:id)
        expect(response).not_to have_key(:from)
        expect(response).not_to have_key(:to)
      end
    end
  end
end
