Promotexter.configure do |config|
   # Get it from https://portal.promotexter.com/
   config.api_key    = ENV['PROMOTEXTER_API_KEY']
   config.api_secret = ENV['PROMOTEXTER_API_SECRET']

   # Get it from promotexter and head over to Sender IDs
   config.from = 'DEMO'

   # If set to "1", only transactionId will be returned in our response.
   # config.async = nil

   # -------------------------------------------------------
   # Uncomment the lines below to use Delivery Report module
   # https://promotexter.docs.apiary.io/#reference/sms-messaging/single-transaction/send-sms
   # -------------------------------------------------------

   # Must be set to "1" if you want to receive DLR notifications to the indicated dlrCallback. This overrides account settings.
   # config.dlr_report = nil

   # Your own API endpoint where we will be sending DLR notifications. This overrides account settings.
   # config.dlr_callback = nil
 end
