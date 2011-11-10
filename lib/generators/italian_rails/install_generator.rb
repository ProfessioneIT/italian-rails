module ItalianRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates Italian Rails initializer"
      def copy_initializer
        template "initializer.rb", "config/initializers/italian_rails.rb"
      end
      
    end
  end
end
