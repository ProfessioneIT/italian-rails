class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :surname
      t.boolean :male
      t.string :codice_fiscale_code, :limit => 16
      t.string :address1, :limit => 1024
      t.string :address2, :limit => 1024
      t.string :location
      t.string :cap_postal_code, :limit => 5
      t.string :province, :limit => 2

      t.string :birthplace
      t.date :birthdate

      t.timestamps
    end
  end
end
