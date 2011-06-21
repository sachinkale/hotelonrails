class RestaurantTicket < ActiveRecord::Base
  establish_connection :restaurant
  set_table_name "TICKETS"
  set_primary_key "ID"
end

