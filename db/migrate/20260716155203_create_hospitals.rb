class CreateHospitals < ActiveRecord::Migration[8.1]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.string :address_line1, null: false
      t.string :address_line2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.string :country, null: false
      t.string :phone_number, null: false
      t.datetime :date_of_establishment, null: false

      t.timestamps
    end
  end
end
