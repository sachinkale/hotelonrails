class LineItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :checkin
  before_save :block_room
  
  def amount
    (rate  + extraperson + ((rate + extraperson) * tax/100).to_i ) * no_of_days
  end

  def no_of_days
    if freez
      n = (todate - fromdate)/(60 * 60 * 24).floor
    else
      n = (Time.now - fromdate)/(60 * 60 * 24).floor
    end
    (n <=1 )? 1 : n.round
  end

  def actual_days
    (Time.now - fromdate)/(60 * 60 * 24).floor
  end

  private
  def block_room
    room.update_attribute('status','blocked - checked in')
  end

end
