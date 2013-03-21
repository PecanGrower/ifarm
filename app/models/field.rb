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
#  farm_id    :integer
#

class Field < ActiveRecord::Base
  attr_accessible :acreage, :name

  belongs_to :block
  has_many :irrigations, order: 'time'

  default_scope { where(company_id: Company.current_id) }

  validates :name, presence: true,
                   uniqueness: { scope: :block_id },
                   length: { maximum: 10 }
  validates :acreage, numericality: true, allow_nil: true
  validates :company_id, presence: true

  def name_with_block
    block.name + "-" + name
  end

  def self.current_irrigations
    Field.all.map do |field|
      if field.irrigations.last
        field.irrigations.last
      else
        field.irrigations.new(time: Time.new(Time.zone.now.year)+1.day)
      end
    end
  end

end
