require 'net/http'
require 'json'

module Promotexter

  class Error < StandardError
    def initialize(message)
      super(message)
    end
  end

  class BadRequestError < Error; end

  class AuthenticationError < Error; end

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

      MESSAGE_PARAMS['api_key'] =  @api_key
      MESSAGE_PARAMS['api_secret'] =  @api_secret
      MESSAGE_PARAMS['from'] =  @from
    end

    def send_message(params = {})
      uri = URI(@host+SMSAPI_PATH)
      MESSAGE_PARAMS['to'] =  params[:to]
      MESSAGE_PARAMS['text'] =  params[:text]

      res = Net::HTTP.post_form(uri, MESSAGE_PARAMS)
      puts res.inspect
      response = JSON.parse(res.body, symbolize_names: true)

      if response.has_key?(:statusCode)
        case
        when 400
          raise BadRequestError.new(message: response[:message])
        when 401
          raise AuthenticationError.new(message: response[:message])
        else
          raise Error.new(response[:message])
        end
      else
        response
      end
    end
  end
end