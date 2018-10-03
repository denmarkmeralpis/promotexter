# Get transaction lists
module Promotexter
   # report class
   class Report < Base
      attr_accessor :after, :before, :transaction_id, :reference_id, :category_id, :request_id, :from, :to

      def initialize(options={})
         @api_key        = options[:api_key]
         @api_secret     = options[:api_secret]
      end

      def sms_transactions(filters={})
         @after          = filters[:after]
         @before         = filters[:before]
         @transaction_id = filters[:transaction_id]
         @reference_id   = filters[:reference_id]
         @category_id    = filters[:category_id]
         @request_id     = filters[:request_id]
         @from           = filters[:from]
         @to             = filters[:to]

         endpoint  = API_HOST + '/api/sms'
         uri       = URI(endpoint)
         uri.query = request_params.to_query

         request   = Net::HTTP.get_response(uri)
         Promotexter::ResponseParser.new(request.body).parse
      end

      def self.sms_transactions(options={})
         new(options).sms_transactions(options)
      end

      def balance
         endpoint  = API_HOST + '/api/account/balance'
         uri       = URI(endpoint)
         uri.query = request_params.to_query

         request = Net::HTTP.get_response(uri)
         Promotexter::ResponseParser.new(request.body).parse
      end

      def self.balance(options={})
         new(options).balance
      end

      private

      def request_params
         reset_uri_params
         uri_params[:apiKey]                  = api_key
         uri_params[:apiSecret]               = api_secret
         uri_params[:filter]                  = {}
         uri_params[:filter][:dateCreatedGt]  = after unless after.blank?
         uri_params[:filter][:dateCreatedLt]  = before unless before.blank?
         uri_params[:filter][:transactionId]  = transaction_id unless transaction_id.blank?
         uri_params[:filter][:referenceId]    = reference_id unless reference_id.blank?
         uri_params[:filter][:categoryId]     = category_id unless category_id.blank?
         uri_params[:filter][:requestId]      = request_id unless request_id.blank?
         uri_params[:filter][:from]           = from unless from.blank?
         uri_params[:filter][:to]             = to unless to.blank?
         uri_params
      end
   end
end