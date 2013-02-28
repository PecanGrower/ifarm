class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.decimal :acreage
      t.integer :block_id
      t.integer :company_id

      t.timestamps
    end
    add_index :fields, :block_id
    add_index :fields, :company_id
  end
end
