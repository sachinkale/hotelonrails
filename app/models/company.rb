class Company < ActiveRecord::Base
  has_many :checkins
end
