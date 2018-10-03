require 'net/http'
require 'json'

# namespace
module Promotexter
  # sending of sms
  class Client < Base
    attr_accessor :sender_id, :to, :text, :reference_id, :category_id

    def initialize(options={})
      @api_key      = options[:api_key]
      @api_secret   = options[:api_secret]
      @sender_id    = options[:sender_id]
      @reference_id = options[:reference_id]
      @category_id  = options[:category_id]
    end

    def send_message(options={})
      @to   = options.fetch(:to)
      @text = options.fetch(:text)

      endpoint = API_HOST + '/api/sms'
      uri      = URI(endpoint)
      request  = Net::HTTP.post_form(uri, request_params)
      Promotexter::ResponseParser.new(request.body).parse
    end

    def self.send_message(options={})
      new(options).send_message(options)
    end

    private

    def request_params
      reset_uri_params
      uri_params[:apiKey]      = api_key
      uri_params[:apiSecret]   = api_secret
      uri_params[:sender_id]   = sender_id
      uri_params[:to]          = to
      uri_params[:text]        = text
      uri_params[:dlrReport]   = Promotexter.configuration.dlr_report   unless Promotexter.configuration.dlr_report.blank?
      uri_params[:dlrCallback] = Promotexter.configuration.dlr_callback unless Promotexter.configuration.dlr_callback.blank?
      uri_params[:async]       = Promotexter.configuration.async        unless Promotexter.configuration.async.blank?
      uri_params[:referenceId] = reference_id unless reference_id.blank?
      uri_params[:categoryId]  = category_id  unless category_id.blank?
      uri_params
    end
  end
end
