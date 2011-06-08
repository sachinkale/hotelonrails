class Checkin < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :service_items, :dependent => :destroy
  has_many :payments, :dependent => :destroy

  has_and_belongs_to_many :guests
  belongs_to :company
  belongs_to :bill_to_owner,:polymorphic => true


  def pending_balance
    total_charges - payments.sum(:amount)
  end

  def total_charges
    li_amount = 0
    line_items.each do |li|
      li_amount += li.amount
    end
    li_amount + service_items.sum(:amount)
  end

  def discount?
    line_items.each do |li|
      if li.rate < li.room.room_type.baserate
        return true
      end
    end
    return false
  end

  def extraperson?
    line_items.each do |li|
      if not li.extraperson.nil? and li.extraperson != 0
        return true
      end
    end
    return false
  end

  def can_split?
    if line_items.length < 2
      return false
    elsif line_items.length == 2 
      line_items.each do |li|
        if li.freez
          return false
        end
      end
    end
    return true
  end

  def revenue_for_day(mydate)
    total = 0
    payment = 0
    line_items.each do |li|
      if status.nil? 
        if mydate > li.fromdate.to_date and not li.freez
          total += li.amount_per_day
        elsif li.freez and li.todate.to_date > mydate
          total += li.amount_per_day      
        end
      else
        total += li.amount_per_day if li.todate.to_date > mydate and li.fromdate.to_date < mydate
      end
    end


    s = ServiceItem.arel_table
    st_time = mydate.to_time.beginning_of_day
    en_time = mydate.to_time.end_of_day


    total += service_items.select("sum(amount) as amt").where(s[:date].gteq(st_time)).where(s[:date].lteq(en_time))[0].amt.to_i

    p = Payment.arel_table
    payment += payments.select("sum(amount) as amt").where(p[:created_at].gteq(st_time)).where(p[:created_at].lteq(en_time))[0].amt.to_i


    return total,payment,line_items.length
  end


  def checkout
    line_items.each do |li|
      li.update_attribute(:todate, Time.now.in_time_zone)
      li.room.update_attribute('status',nil)
    end
    update_attribute(:status, "checked out")
    update_attribute(:todate, Time.now.in_time_zone)
  end

  def update_fromdate
    update_attribute(:fromdate,line_items.order("fromdate asc")[0].fromdate)
  end


end

