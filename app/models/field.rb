# == Schema Information
#
# Table name: fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  acreage    :decimal(, )
#  block_id   :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Field < ActiveRecord::Base
  attr_accessible :acreage, :name

  belongs_to :block

  default_scope { where(company_id: Company.current_id) }

  validates :name, presence: true,
                   uniqueness: { scope: :block_id },
                   length: { maximum: 10 }
  validates :acreage, numericality: true, allow_nil: true
  validates :block_id, presence: true
  validates :company_id, presence: true

end
