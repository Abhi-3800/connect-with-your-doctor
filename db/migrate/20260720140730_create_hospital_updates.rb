class CreateHospitalUpdates < ActiveRecord::Migration[8.1]
  def change
    create_table :hospital_updates do |t|
      t.string :updated_by
      t.text :reason, null: :false
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
