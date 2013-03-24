class AddSoilClassIdToFields < ActiveRecord::Migration
  def change
    add_column :fields, :soil_class_id, :integer
    add_index :fields, :soil_class_id
  end
end
