class AddWeatherStationIdToFarms < ActiveRecord::Migration
  def change
    add_column :farms, :weather_station_id, :integer
    add_index :farms, :weather_station_id
  end
end
