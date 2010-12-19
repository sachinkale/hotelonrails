class LineItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :checkin
  before_save :block_room
  
  def amount
    (rate  + extraperson + ((rate + extraperson) * tax/100).to_i ) * no_of_days
  end

  def no_of_days
    n = (Time.now - fromdate)/(60 * 60 * 24).floor
    (n <=1 )? 1 : n.round
  end
  private
  def block_room
    room.update_attribute('status','blocked')
  end

end
