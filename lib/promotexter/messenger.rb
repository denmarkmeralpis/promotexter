require File.join(File.dirname(__FILE__), 'http_client.rb')

module Promotexter
   class Messenger

      include HttpClient

      def initialize domain, clientid, senderid, passkey
         @domain   = domain
         @clientid = clientid
         @senderid = senderid
         @passkey  = passkey
      end

      def send_sms message, recipient
         message = URI.encode(message)
         url = "#{@domain}/sendsms.php?clientid=#{@clientid}&passkey=#{@passkey}&msisdn=#{recipient}&message=#{message}&senderid=#{@senderid}&encoding=url"
         get(url)
      end

      def get_balance
         url = "#{@domain}/getbalance.php?clientid=#{@clientid}&passkey=#{@passkey}"
         get(url)
      end

   end
end
