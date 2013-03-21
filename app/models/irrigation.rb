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
    d = time.yday
    t5 = (d ** 5) *  0.00000000081405
    t4 = (d ** 4) * -0.00000064165
    t3 = (d ** 3) *  0.00018096
    t2 = (d ** 2) * -0.019768
    t1 = (d ** 1) * 0.23585
    t0 = (d ** 0) * 72.258
    interval = t5 + t4 + t3 + t2 + t1 + t0
    time + interval.days
  end

end
