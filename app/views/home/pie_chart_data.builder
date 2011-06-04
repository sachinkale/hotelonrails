xml= Builder::XmlMarkup.new
 xml.graph(:caption=>'Room Occupancy', :decimalPrecision=>'0', :showNames=>'1', :pieSliceDepth =>'30', :formatNumberScale=>'0',:bgAlpha => 100, :bgColor => "aaaaaa") do
   xml.set(:name => "Not in Use", :value => @m_rooms)
   xml.set(:name=>"Occupied",:value=> @o_rooms) 
   xml.set(:name => "Unoccupied", :value => @un_rooms)
end

