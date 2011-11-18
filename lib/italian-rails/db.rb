require 'sqlite3'
require 'singleton'

module ItalianRails
  module DB

    # This class is responsible to interface with the lookup embedded
    # database. It stores the procedures and the informations needed to
    # retrieve the data.
    class Adapter
      include Singleton

      # Set the database path
      def initialize
        @db_path =  File.join(File.dirname(__FILE__), "data", "italian-rails.db3")
      end

      def find_birth_places_by_code(code)
        ret = []
        SQLite3::Database.new( @db_path ) do |db|
          db.execute("select comune, provincia from tab_codici_cf where codice=?", [code]) do |row|
            ret << {:comune => row[0], :provincia => row[1]}
          end
        end
        ret
      end

    end
  end
end
