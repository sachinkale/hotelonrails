class RestaurantPayment < ActiveRecord::Base
  establish_connection :restaurant
  set_table_name "PAYMENTS"
  set_primary_key "ID"
end

