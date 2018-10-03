require_relative '../spec_helper'

RSpec.describe Promotexter::ResponseParser do
  let(:bad_request) { '{ "code": "200202", "message": "The recipient is invalid." }' }
  let(:not_accepted)   { '{ "code": "200101", "message": "The account has no credit." }' }
  let(:unauthorized)   { '{ "code": "40001", "message": "Unauthorized Access." }' }
  let(:standard_error) { '{ "code": "50000", "message": "General Error" }' }
  let(:success) do
    '{ "id": "bfc09f4b-55c7-48d0-9948-c3a41692cb4a",
       "unitCost": 0.5,
       "transactionCost": 0.5,
       "operatorCode": "PHL_GLOBE",
       "messageParts": 1,
       "from": "DEMO",
       "to": "639177710296",
       "source": "119.93.137.44",
       "remaining": 497 }'
  end

  context 'With success response' do
    it 'returns response' do
      response = Promotexter::ResponseParser.parse(success)
      expect(response).to have_key(:id)
      expect(response).to have_key(:from)
      expect(response).to have_key(:to)
    end
  end

  context 'Bad Request' do
    it 'raises bad request error' do
      expect { Promotexter::ResponseParser.new(bad_request).parse }.to raise_error(Promotexter::Errors::BadRequest)
    end
  end

  context 'Not Accepted' do
    it 'fails request due to account related error' do
      expect { Promotexter::ResponseParser.new(not_accepted).parse }.to raise_error(Promotexter::Errors::NotAccepted)
    end
  end

  context 'Unauthorized' do
    it 'raises error due to invalid api key/secret' do
      expect { Promotexter::ResponseParser.new(unauthorized).parse }.to raise_error(Promotexter::Errors::Authentication)
    end
  end

  context 'Standard Error' do
    it 'raises general error' do
      expect { Promotexter::ResponseParser.new(standard_error).parse }.to raise_error(StandardError)
    end
  end

  context 'Class method #parse' do
    it 'returns parse hash' do
      expect(Promotexter::ResponseParser.parse(success)).to have_key(:id)
    end
  end
end
