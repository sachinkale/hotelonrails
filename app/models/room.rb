class Room < ActiveRecord::Base
  belongs_to :room_type
  has_many :line_items
  cattr_reader :per_page
  @@per_page = 12
  scope :available,{:conditions => "status is NULL"}

  def roomtype
    return number + " - " + room_type.name + " # " + room_type.baserate.to_s
  end

  def current_checkin
    line_items.each do |li|
      if li.checkin.status.nil? and not li.freez
        return li.checkin
      end
    end
    return nil
  end

end
