class Block < ActiveRecord::Base
  attr_accessible :name

  default_scope { where(company_id: Company.current_id) }

  belongs_to :farm

  validates :name, presence: true,
                    uniqueness: { scope: :farm_id },
                    length: { maximum: 10 }
  validates :farm_id, presence: true
  validates :company_id, presence: true
end