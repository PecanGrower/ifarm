class CreateWeatherStations < ActiveRecord::Migration
  def change
    create_table :weather_stations do |t|
      t.string :name
      t.string :id_code
      t.string :db_col

      t.timestamps
    end
  end
end
