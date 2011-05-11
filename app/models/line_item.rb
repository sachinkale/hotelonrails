class LineItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :checkin
  before_save :block_room
  before_destroy :unblock_room
  
  def amount
    (rate  + extraperson + ((rate + extraperson) * tax/100).to_i ) * no_of_days
  end

  def no_of_days
    n = 0

    from = fromdate.in_time_zone(APP_CONFIG['hotel_time_zone'])
    today = Time.now.in_time_zone(APP_CONFIG['hotel_time_zone'])

    n = n + 1 if from.hour < APP_CONFIG['hotel_checkout_hour'] 

    n = n + 1 if today.hour > APP_CONFIG['hotel_checkout_hour'] 

    return n + (today.to_date - from.to_date).to_i
  end


  private
  def block_room
    room.update_attribute('status','blocked - checked in')
  end

  def unblock_room
    room.update_attribute('status',nil)
  end

end
