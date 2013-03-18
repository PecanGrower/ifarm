class Report < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.generate(name)
    Report.send(name)
  end

  def self.next_irrigations
    Field.current_irrigations
  end
end
