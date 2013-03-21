class AddFarmIdToIrrigations < ActiveRecord::Migration
  def change
    add_column :irrigations, :farm_id, :integer
    add_index :irrigations, :farm_id
  end
end
