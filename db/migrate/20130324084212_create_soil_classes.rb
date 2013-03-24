class CreateSoilClasses < ActiveRecord::Migration
  def change
    create_table :soil_classes do |t|
      t.string :name
      t.decimal :aw

      t.timestamps
    end
  end
end
