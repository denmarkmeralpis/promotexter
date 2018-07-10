require 'test_helper'

class PromotexterTest < ActiveSupport::TestCase
   # test "truth" do
   #    assert_kind_of Module, Promotexter
   # end

   test "Send SMS" do
      clientid = '20000739'
      passkey  = 'E5CD404AB8CE31EB7E4906D3D90271D8'
      msisdn   = '639778198061'
      senderid = 'Demo'
      message  = URI.escape(message)

      rest_provider = Promotexter::Base.new(clientid, senderid, passkey)
      response = rest_provider.send_sms('Testing Promotexter Gem 0.0.2', '639778198061')
      assert_not_equal(response.body.to_s, '-1')
   end

end
