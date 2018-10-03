require 'promotexter/version'
require 'promotexter/errors/base'
require 'promotexter/configuration'
require 'promotexter/base'
require 'promotexter/client'
require 'promotexter/report'
require 'promotexter/response_parser'
require 'generators/promotexter/install_generator'

# Promotexter configuration block
module Promotexter
   class << self
     attr_accessor :configuration
   end

   def self.configuration
     @configuration ||= Configuration.new
   end

   def self.reset
     @configuration = Configuration.new
   end

   def self.configure
     yield(configuration)
   end
 end
