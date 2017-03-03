module Promotexter
   class Base

		attr_accessor :configuration

      def initialize clientid, senderid
         @domain   = "http://promotexter.com"
         @clientid = clientid
         @senderid  = senderid
			@api_key = Promotexter.configure.api_key
      end

      def send_sms(message, recipient)
         messenger = Messenger.new @domain, @clientid, @senderid, @api_key
         messenger.send_sms(message, recipient)
      end

      def get_balance
         messenger = Messenger.new @domain, @clientid, @senderid, @api_key
         messenger.get_balance
      end

   end
end
