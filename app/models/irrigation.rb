class Irrigation < ActiveRecord::Base
  attr_accessible :time

  belongs_to :field

  default_scope { where(company_id: Company.current_id) }

  validates :time, presence: true

end
