class AddFarmIdToFields < ActiveRecord::Migration
  def change
    add_column :fields, :farm_id, :integer
    add_index :fields, :farm_id
  end
end
