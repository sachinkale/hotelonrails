# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Creating Room Types
room_types = RoomType.create([{ :name => "Economy Non AC", :baserate => "990"},{:name => "Economy AC", :baserate => "1190"},{:name => "Semi Deluxe", :baserate => "1390"},{:name => "Deluxe", :baserate => "1790"}])

#Creating 24 rooms divided into two floors/sections - [{101 - 112} , {201 - 212}], 3 rooms of each room-type on single floor/section

room_types1 = Array.new

Company.create(:name => "None") #default company for walkins
Service.create([{:name => "Room Service"},{:name => "Laundry Service"}])

1.upto(24) do |i|
  if i < 13
    number = 100 + i
    room_types1 << room_types.shift if (( i > 1 ) && ((i - 1) % 3 == 0))
    room_type = room_types.first
  else
    j = i - 12
    room_types1 << room_types.first if j == 1
    number = 200 + j
    room_types1.shift if ((j > 1) && ((j - 1) % 3 == 0))
    room_type = room_types1.first
  end
  Room.create(:number => number, :room_type_id => room_type.id)
end
  
