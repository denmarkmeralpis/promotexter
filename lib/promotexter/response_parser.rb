module Promotexter
   class ResponseParser
      attr_accessor :response

      def initialize(response)
         @response = JSON.parse(response, symbolize_names: true)
      end

      def parse
         if response.key?(:code)
            error_code_parser
         else
            response
         end
      end

      def self.parse(response)
         new(response).parse
      end

      private

      def error_code_parser
         case response[:code].to_i
         when 200100, 200301,200102, 200201, 200202, 200203, 200204, 200205, 200206, 40002, 40003, 40004, 40005, 40006, 40007, 50001
            raise Errors::BadRequest, response[:message]
         when 200101, 500101
            raise Errors::NotAccepted, response[:message]
         when 40001
            raise Errors::Authentication, response[:message]
         else
            raise StandardError, response[:message]
         end
      end

   end
end