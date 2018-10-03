module Promotexter
   class Base
      API_HOST = 'https://rest-portal.promotexter.com'.freeze

      def api_key
         @api_key ||= Promotexter.configuration.api_key
      end

      def api_secret
         @api_secret ||= Promotexter.configuration.api_secret
      end

      def uri_params
         @uri_params ||= {}
      end

      private

      def reset_uri_params
         uri_params = {}
      end
   end
end