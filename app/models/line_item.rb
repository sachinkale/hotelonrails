class LineItem < ActiveRecord::Base
  belongs_to :room
  belongs_to :checkin
  
  def amount
    (rate  + extraperson + tax ) * no_of_days
  end

  def no_of_days
    n = (Time.now - fromdate)/(60 * 60 * 24).floor
    (n <=0 )? 1 : n.round
  end

end
