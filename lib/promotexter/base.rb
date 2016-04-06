module Promotexter
   class Base

      def initialize clientid, senderid, passkey
         @domain   = "http://promotexter.com"
         @clientid = clientid
         @senderid = senderid
         @passkey  = passkey
      end

      def send_sms(message, recipient)
         messenger = Messenger.new @domain, @clientid, @senderid, @passkey
         messenger.send_sms(message, recipient)
      end

      def get_balance
         messenger = Messenger.new @domain, @clientid, @senderid, @passkey
         messenger.get_balance
      end

   end
end
