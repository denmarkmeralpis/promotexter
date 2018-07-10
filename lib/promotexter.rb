require 'promotexter/version'
require 'promotexter/http_client'
require 'promotexter/messenger'
require 'promotexter/base'

module Promotexter

	attr_accessor :configuration

	class << self
		attr_accessor :configuration
	end

	def self.configure
		self.configuration ||= Configuration.new
		# yield(configuration)
	end

	class Configuration

		attr_accessor :api_key

		def initialize
			@api_key = ''
		end
	end

end
