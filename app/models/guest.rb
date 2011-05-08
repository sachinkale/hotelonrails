class Guest < ActiveRecord::Base
  has_and_belongs_to_many :checkins
  validates_presence_of :FirstName
  validates_presence_of :LastName

  def name
    self.FirstName  + " " + self.LastName
  end
end
