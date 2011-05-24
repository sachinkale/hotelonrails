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


  def checkout
    line_items.each do |li|
      li.update_attribute(:todate, Time.now.in_time_zone)
      li.room.update_attribute('status',nil)
    end
    update_attribute(:status, "checked out")
  end

end

