Promotexter.configure do |config|
  # Get it from https://portal.promotexter.com/
  config.api_key = ENV['PROMOTEXTER_API_KEY']
  config.api_secret = ENV['PROMOTEXTER_API_SECRET']

  # Get it from promotexter portal under to Sender IDs tab
  config.sender_id = ENV['PROMOTEXTER_SENDER_ID']

  # If set to true, only transactionId will be returned in promotexter response.
  # config.async = true

  # -------------------------------------------------------
  # Uncomment the lines below to use Delivery Report module
  # See full documentation at https://promotexter.docs.apiary.io/
  # -------------------------------------------------------

  # Must be set this to true if you want to receive DLR notifications to the indicated dlr_callback. This overrides account settings.
  # config.dlr_report = true

  # Your own API endpoint where we will be sending DLR notifications. This overrides account settings.
  # config.dlr_callback = 'https://example.com'
end
