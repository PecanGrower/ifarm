class CreateEts < ActiveRecord::Migration
  def change
    create_table :ets do |t|
      t.integer :doy
      t.decimal :fabian_garcia

      t.timestamps
    end
    add_index :ets, :doy
  end
end
