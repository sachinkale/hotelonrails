class Checkin < ActiveRecord::Base
  has_many :line_items
  has_many :service_items
  has_many :payments
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

end

