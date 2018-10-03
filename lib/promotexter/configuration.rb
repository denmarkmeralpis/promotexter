# namespacing
module Promotexter
  # class cofiguration
  class Configuration
    attr_writer :api_key, :api_secret, :sender_id, :dlr_callback, :dlr_report, :async

    def initialize
      @api_key, @api_secret, @sender_id, @dlr_callback, @dlr_report, @async = nil
    end

    def api_key
      raise Errors::Configuration, 'Promotexter api_key is missing! See documentation for configuration settings.' unless @api_key
      @api_key
    end

    def api_secret
      raise Errors::Configuration, 'Promotexter api_secret is missing! See documentation for configuration settings.' unless @api_secret
      @api_secret
    end

    def sender_id
      raise Errors::Configuration, 'Promotexter sender_id is missing! See documentation for configuration settings.' unless @sender_id
      @sender_id
    end

    attr_reader :dlr_callback

    attr_reader :dlr_report

    attr_reader :async
  end
end
