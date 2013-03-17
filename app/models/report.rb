class Report < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.generate(name)
    Report.send(name)
  end

  def self.next_irrigation
    Irrigation.next_irrigations
  end
end
