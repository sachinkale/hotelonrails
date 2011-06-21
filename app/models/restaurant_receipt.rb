class RestaurantReceipt < ActiveRecord::Base
  establish_connection :restaurant
  set_table_name "RECEIPTS"
  set_primary_key "ID"
end

