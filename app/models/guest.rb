class Guest < ActiveRecord::Base
  has_and_belongs_to_many :checkins

  def name
    self.FirstName  + " " + self.LastName
  end
end
