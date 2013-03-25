class WeatherStation < ActiveRecord::Base
  attr_accessible :db_col, :id_code, :name

  has_many :farms

  validates :name, presence: true
  validates :db_col, presence: true
  validates :id_code, presence: true
end