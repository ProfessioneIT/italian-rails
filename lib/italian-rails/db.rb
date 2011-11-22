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
        query do |db,ret|
          db.execute("select comune, provincia from tab_codici_cf where codice=?", [code]) do |row|
            ret << {:comune => row[0], :provincia => row[1]}
          end
        end
      end

      def find_cities_by_cap(cap)
        query do |db,ret|
          db.execute("select prov_cap, comu_cap, fraz_cap from tab_cap where capi_cap=?", [cap]) do |row|
            ret << {:provincia => row[0], :comune => row[1], :frazione => row[2]}
          end
        end
      end

      def find_places_by_prov(prov)
        query do |db,ret|
          db.execute("select comu_cap, fraz_cap, capi_cap from tab_cap where prov_cap=?", [prov]) do |row|
            ret << {:comune => row[0], :frazione => row[1], :cap => row[2]}
          end
        end
      end

      def query
        if block_given?
          ret = []
          SQLite3::Database.new( @db_path ) do |db|
            yield(db,ret)
          end
          ret
        end
      end


    end
  end
end
