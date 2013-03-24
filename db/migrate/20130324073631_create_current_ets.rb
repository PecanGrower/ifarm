class CreateCurrentEts < ActiveRecord::Migration
  def change
    create_table :current_ets do |t|
      t.integer :doy
      t.decimal :fabian_garcia

      t.timestamps
    end
    add_index :current_ets, :doy
  end
end
