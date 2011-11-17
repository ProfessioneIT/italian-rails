require 'sqlite3'
require 'singleton'

module ItalianRails
  module DB
    class Adapter
      include Singleton

      def initialize
        @db_path =  File.join(File.dirname(__FILE__), "data", "italian-rails.db3")
      end

      def execute(sql, bind_vars = [], *args, &block)
        SQLite3::Database.new( @db_path ) do |db|
          db.execute(sql, bind_vars, *args, &block)
        end
      end

    end
  end
end
