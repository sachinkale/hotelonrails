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
    Checkin.where("status is NULL").each do |c|
      c.line_items.each do |li|
        return c if not li.freez and li.room_id == id
      end
    end
    return nil
    #Checkin.where("status is NOT NULL").line_items.each 
  end

  def find_checkin_by_time(time)
    li = LineItem.arel_table
    litems = LineItem.where(li[:fromdate].lteq(time)).where(:room_id => id)
    litems.each do |lit|
      if lit.checkin.status.nil? and not lit.freez
        return lit.checkin
      elsif lit.todate > time
        return lit.checkin
      end
    end
    return nil
  end

end
