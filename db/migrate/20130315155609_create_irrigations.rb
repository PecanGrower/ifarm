class CreateIrrigations < ActiveRecord::Migration
  def change
    create_table :irrigations do |t|
      t.datetime :time
      t.integer :field_id

      t.timestamps
    end
    add_index :irrigations, :field_id
  end
end
