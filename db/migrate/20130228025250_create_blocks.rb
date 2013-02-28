class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :name
      t.integer :farm_id
      t.integer :company_id

      t.timestamps
    end
    add_index :blocks, :farm_id
    add_index :blocks, :company_id
  end
end
