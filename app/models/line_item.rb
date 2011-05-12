class LineItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :checkin
  before_save :block_room
  before_destroy :unblock_room

  validates_numericality_of :rate
  validates_numericality_of :extraperson
  
  def amount
    amount_per_day * no_of_days
  end
  
  def amount_per_day
    (rate  + extraperson + ((rate + extraperson) * tax/100).to_i ) 
  end


  def no_of_days
    n = 0

    today = Time.now.in_time_zone(APP_CONFIG['hotel_time_zone'])

    n = n + 1 if from.hour < APP_CONFIG['hotel_checkout_hour'] 

    n = n + 1 if today.hour > APP_CONFIG['hotel_checkout_hour'] 

    return n + (today.to_date - from.to_date).to_i
  end

  def from
    fromdate.in_time_zone(APP_CONFIG['hotel_time_zone'])
  end

  def discount
    (100 - (rate.to_f/room.room_type.baserate.to_f) * 100).round(2)
  end

  private
  def block_room
    room.update_attribute('status','blocked - checked in')
  end

  def unblock_room
    room.update_attribute('status',nil)
  end

end
