# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  attr_accessible :name, :users_attributes

  has_many :users
  accepts_nested_attributes_for :users

  validates :name, presence: true,
                   length: { maximum: 50 }

  # def user_attributes=(user_attributes)
  #   user_attributes.each do |attributes|
  #     users.build(attributes)      
  #   end
  # end
end
