class User < ActiveRecord::Base
  validates_presence_of :name, :surname, :birthdate, :birthplace
  validates_codice_fiscale_of :codice_fiscale_code
end
