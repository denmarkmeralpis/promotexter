require 'rails/generators'

# name
module Promotexter
  # Generator
  module Generators
    # Class generatpr
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      desc 'Creates promotexter.rb initializer for your application'

      def copy_initializer
        template 'promotexter_initializer.rb', 'config/initializers/promotexter.rb'
        puts 'Done install! Configure the file in config/initializers/promotexter.rb'
      end
    end
  end
end
