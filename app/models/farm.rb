# == Schema Information
#
# Table name: farms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#

class Farm < ActiveRecord::Base
  attr_accessible :name

  default_scope { where(company_id: Company.current_id) }

  has_many :blocks

  validates :name, presence: true,
                    uniqueness: { scope: :company_id },
                    length: { maximum: 50 }
  validates :company_id, presence: true
end
