class CreateMeterReadings < ActiveRecord::Migration
  def change
    create_table :meter_readings do |t|
      t.integer :irrigation_id
      t.integer :irrigation_well_id
      t.integer :company_id
      t.integer :start
      t.integer :stop

      t.timestamps
    end
    add_index :meter_readings, :irrigation_id
    add_index :meter_readings, :irrigation_well_id
    add_index :meter_readings, :company_id
  end
end
