# require 'uri'
# require 'test_helper'
#
# class SmsTest < ActiveSupport::TestCase
#
#    def test_to_send_sms
#       clientid='20000739'
#       passkey='E5CD404AB8CE31EB7E4906D3D90271D8'
#       msisdn='639778198061'
#       message='Hello World!'
#       senderid='Demo'
#       message = URI.escape(message)
#       domain = "http://promotexter.com"
#
#       restprovider = Promotexter::Base.new(clientid, senderid, passkey)
#       response = restprovider.send_sms(message, msisdn)
#    end
#
# end
