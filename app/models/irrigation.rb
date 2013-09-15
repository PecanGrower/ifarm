# == Schema Information
#
# Table name: irrigations
#
#  id         :integer          not null, primary key
#  time       :datetime
#  field_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#  farm_id    :integer
#

class Irrigation < ActiveRecord::Base
  attr_accessible :time, :meter_readings_attributes
  attr_accessor :next_irrigation

  belongs_to :field
  has_many :meter_readings
  accepts_nested_attributes_for :meter_readings

  default_scope { where(company_id: Company.current_id) }

  validates :time, presence: true

  def self.next_irrigations
    current_irrigations = 
      Field.includes(:irrigations).map do |field|
        if field.irrigations.last
          field.irrigations.order("time").last
        else
          field.irrigations.new(time: Time.new(Time.zone.now.year)-184.days)
        end
      end
    et ||= Et.order("doy")
    kc ||= Kc.order("doy")
    current_et ||= CurrentEt.order("doy")
    current_irrigations.each do |irrigation|
      irrigation.next_irrigation = irrigation.next_irrigation_date(et, kc, current_et)
    end
  end

  def next_irrigation_date(et, kc, current_et)
    max_aw = field.soil_class.aw
    station = field.block.farm.weather_station
    mad = 0.45
    aw = max_aw * mad
    interval = 0
    date = time.to_date
    while aw > 0
      doy = date.yday
      etref = current_et[doy-1].send(station.db_col) || 
              et[doy-1].send(station.db_col)
      kcref = kc[doy-1].pecan
      aw -= etref * kcref
      if aw > max_aw * mad
        aw = max_aw * mad
      end
      date += 1
    end
    date
  end
end