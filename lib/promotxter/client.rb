require 'net/http'

module Promotxter

  class Response
    attr_reader :status, :message_id

    def initialize(http_response)
      response = JSON.parse(http_response.body)
      @status = response['status']
      @message_id = response['message']['id']
    end
  end

  class Client
    attr_accessor :api_secret, :api_key, :from, :http, :to, :text
    SMSAPI_PATH = '/sms/send'
    MESSAGE_PARAMS = {}

    def initialize(options = {})
      @api_key = options[:api_key]
      @api_secret = options[:api_secret]
      @from = options[:from]

      @host = 'https://rest-portal.promotexter.com'
      @http = Net::HTTP.new(@host, Net::HTTP.https_default_port)

      MESSAGE_PARAMS['apiKey'] =  @api_key
      MESSAGE_PARAMS['apiSecret'] =  @api_secret
      MESSAGE_PARAMS['from'] =  @from
    end

    def send_message(params = {})
      uri = URI(@host+SMSAPI_PATH)
      puts uri
      MESSAGE_PARAMS['to'] =  params[:to]
      MESSAGE_PARAMS['text'] =  params[:text]
      puts MESSAGE_PARAMS

      res = Net::HTTP.post_form(uri, MESSAGE_PARAMS)
      return Response.new(res)
    end
  end
end