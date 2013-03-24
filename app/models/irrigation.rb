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
  attr_accessible :time

  belongs_to :field

  default_scope { where(company_id: Company.current_id) }

  validates :time, presence: true

  def next_irrigation
    max_aw = field.soil_class.aw
    mad = 0.45
    aw = max_aw * mad
    interval = 0
    doy = time.yday
    et = Et.order("doy")
    kc = Kc.order("doy")
    current_et = CurrentEt.order("doy")
    while aw > 0
      etref = current_et[doy-1].fabian_garcia || et[doy-1].fabian_garcia
      kcref = kc[doy-1].pecan
      aw -= etref * kcref
      doy += 1
      interval += 1
    end
    time.to_date + interval.days
  end
end