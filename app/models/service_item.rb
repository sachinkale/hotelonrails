class ServiceItem < ActiveRecord::Base
  belongs_to :service
  belongs_to :checkin
  belongs_to :room
end
