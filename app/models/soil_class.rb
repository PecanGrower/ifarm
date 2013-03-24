class SoilClass < ActiveRecord::Base
  attr_accessible :aw, :name

  has_many :fields
end
