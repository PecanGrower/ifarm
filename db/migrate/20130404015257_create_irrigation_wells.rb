class CreateIrrigationWells < ActiveRecord::Migration
  def change
    create_table :irrigation_wells do |t|
      t.string :name
      t.string :pod_code
      t.integer :farm_id

      t.timestamps
    end
    add_index :irrigation_wells, :farm_id
  end
end
