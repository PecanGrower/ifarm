class CreateKcs < ActiveRecord::Migration
  def change
    create_table :kcs do |t|
      t.integer :doy
      t.decimal :pecan

      t.timestamps
    end
    add_index :kcs, :doy
  end
end
