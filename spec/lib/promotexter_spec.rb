require 'spec_helper'

describe Promotexter do
   it 'should return invoice number' do
      clientid = '20000739'
      passkey  = 'E5CD404AB8CE31EB7E4906D3D90271D8'
      msisdn   = '639778198061'
      senderid = 'Demo'
      rest_provider = Promotexter::Base.new(clientid, senderid, passkey)
      response = rest_provider.send_sms('This is a rspec test', msisdn)
      p "RESPONSE: #{response.body}"
   end

   it 'get balance' do
      clientid = '20000739'
      passkey  = 'E5CD404AB8CE31EB7E4906D3D90271D8'

      rest_provider = Promotexter::Base.new(clientid, nil, passkey)
      response = rest_provider.get_balance
      p "BALANCE: #{response.body}"
   end
end
