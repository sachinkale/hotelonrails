desc "Pull data from restaurant"
task :pull_restaurant_data => [:environment] do |t|
  Room.all.each do |r|
    rp = RestaurantPayment.find_by_sql "SELECT * FROM PAYMENTS WHERE RECEIPT IN (select T.ID from TICKETS T inner join CUSTOMERS C on C.NAME like 'Room #{r.number}' and T.CUSTOMER = C.ID) AND PAYMENT LIKE 'debt';"
    rp.each do |rpe|
      date = RestaurantReceipt.find_by_sql "SELECT DATENEW FROM RECEIPTS where ID = '#{rpe.RECEIPT}'"
      time =date[0].DATENEW
      localtime = Time.local(time.year,time.month,time.day,time.hour,time.min,time.sec)
      checkin = r.find_checkin_by_time(localtime)
      if checkin.nil?
        puts "found nil checkin for " + r.number.to_s
      else
        if checkin.service_items.where(:description => "#{rpe.RECEIPT}")[0].nil?
          rt = RestaurantTicket.find("#{rpe.RECEIPT}")
          checkin.service_items << ServiceItem.new(:service_id => 1, :description => "#{rpe.RECEIPT}", :billnumber => "#{rt.TICKETID}", :amount => "#{rpe.TOTAL}", :room_id => r.id, :date => localtime)
        end
      end
    end
  end
end

