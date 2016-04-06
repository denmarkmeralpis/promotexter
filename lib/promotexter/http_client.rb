require 'net/http'

module Promotexter
  module HttpClient
    def get(url)
      uri = URI(url)

      req = Net::HTTP::Get.new(uri)
            
      Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
        response = http.request req # Net::HTTPResponse object
      end
    end
  end
end
