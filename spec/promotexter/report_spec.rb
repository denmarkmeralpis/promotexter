require_relative '../spec_helper'

RSpec.describe Promotexter::Client do
   let(:host)   { 'https://rest-portal.promotexter.com/api/sms' }
   let(:report) { Promotexter::Report.new }
   let(:query)  { { apiKey: ENV['PROMOTEXTER_API_KEY'], apiSecret: ENV['PROMOTEXTER_API_SECRET'] } }

   before do
      Promotexter.configure do |config|
         config.api_key    = ENV['PROMOTEXTER_API_KEY']
         config.api_secret = ENV['PROMOTEXTER_API_SECRET']
         config.sender_id  = ENV['PROMOTEXTER_SENDER_ID']
      end
   end

   context '#initialize' do
      it { expect(Promotexter::Report.new).to be_an_instance_of(Promotexter::Report) }
   end

   context '#sms_transactions' do
      context 'with configuration block as arguments' do
         let(:with_config) { Promotexter::Report.new(api_key: 'your-api-key', api_secret: 'your-api-secret') }

         it 'should have API key' do
            expect(with_config.api_key).to eq('your-api-key')
         end

         it 'should have API secret' do
            expect(with_config.api_secret).to eq('your-api-secret')
         end
      end

      context 'without filtering parameters' do
         it 'should return list of transactions' do
            stub_request(:get, host).to_return(body: response_body('sms_transactions.json')).with(query: query)
            response = report.sms_transactions

            expect(response).to be_truthy
            expect(response).to have_key(:status)
            expect(response).to have_key(:data)
            expect(response[:status]).to be_truthy
         end
      end

      context 'when given a filter #after' do
         it 'should filter transactions with creation date greater than this value' do
            query[:filter] = { dateCreatedGt: '2018-10-03T14:44:23.186Z' }

            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(after: '2018-10-03T14:44:23.186Z')

            expect(response).to be_truthy
         end
      end

      context 'when given a filter #before' do
         it 'should filter transactions with creation date lesser than this value' do
            query[:filter] = { dateCreatedLt: '2018-10-03T14:44:23.186Z' }

            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(before: '2018-10-03T14:44:23.186Z')

            expect(response).to be_truthy
         end
      end

      context 'when given a filter #transaction_id' do
         it 'should filter specific transactionId' do
            query[:filter] = { transactionId: '1', dateCreatedLt: '2018-10-03T14:44:23.186Z' }
            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(transaction_id: '1', before: '2018-10-03T14:44:23.186Z')
            expect(response).to be_truthy
         end
      end

      context 'when given a filter #categoryId' do
         it 'should filter specific categoryId' do
            query[:filter] = { categoryId: '1' }
            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(category_id: '1')
            expect(response).to be_truthy
         end
      end

      context 'when given a filter #requestId' do
         it 'should filter pecific requestId' do
            query[:filter] = { requestId: '1' }
            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(request_id: '1')
            expect(response).to be_truthy
         end
      end

      context 'when given a filter #from' do
         it 'should lookup by "from" parameter' do
            query[:filter] = { from: '2018-10-03T14:44:23.186Z' }
            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(from: '2018-10-03T14:44:23.186Z')
            expect(response).to be_truthy
         end
      end

      context 'when given a filter #to' do
         it 'should lookup by "to" parameter' do
            query[:filter] = { to: '2018-10-03T14:44:23.186Z' }
            stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
            response = report.sms_transactions(to: '2018-10-03T14:44:23.186Z')
            expect(response).to be_truthy
         end
      end

      context 'direct calling using class method' do
         context 'without options' do
            it 'should have successful response' do
               stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)
               expect(Promotexter::Report.sms_transactions).to be_truthy
            end
         end

         context 'with options' do
            it 'should have successful response' do
               options = { api_key: ENV['PROMOTEXTER_API_KEY'], api_secret: ENV['PROMOTEXTER_API_SECRET'], category_id: 1 }
               query   = { apiKey: ENV['PROMOTEXTER_API_KEY'], apiSecret: ENV['PROMOTEXTER_API_SECRET'], filter: { categoryId: 1 } }
               stub_request(:get, host).to_return(body: response_body('filter_date.json')).with(query: query)

               expect(Promotexter::Report.sms_transactions(options)).to be_truthy
            end
         end
      end
   end

   context '#balance' do
      let(:balance) { Promotexter::Report.new }
      let(:host) { 'https://rest-portal.promotexter.com/api/account/balance' }

      context 'when configuration is given' do
         it 'should have a valid configuration' do
            expect(balance.api_key).to eq(ENV['PROMOTEXTER_API_KEY'])
            expect(balance.api_secret).to eq(ENV['PROMOTEXTER_API_SECRET'])
         end
      end

      context 'when configuration is passed as args' do
         it 'should overrides initializer' do
            instance = Promotexter::Report.new(api_key: 'sample_key', api_secret: 'sample_secret')
            expect(instance.api_key).to eq('sample_key')
            expect(instance.api_secret).to eq('sample_secret')
         end
      end

      context 'when data is valid' do
         it 'should return balance' do
            stub_request(:get, host).to_return(body: response_body('balance.json')).with(query: query)
            expect(balance.balance).to be_truthy
         end
      end

      context 'direct calling via class method' do
         it 'should return balance' do
            stub_request(:get, host).to_return(body: response_body('balance.json')).with(query: query)
            expect(Promotexter::Report.balance).to be_truthy
         end
      end
   end
end