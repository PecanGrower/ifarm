class CreateRains < ActiveRecord::Migration
  def change
    create_table :rains do |t|
      t.date :date
      t.decimal :amount
      t.integer :farm_id
      t.integer :company_id

      t.timestamps
    end
  end
end
