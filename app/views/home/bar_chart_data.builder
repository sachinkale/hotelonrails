xml= Builder::XmlMarkup.new
 xml.graph(:SYAxisName => 'Number of Rooms',:PYAxisName => 'Amount', :showLegend => '1',:caption=>'Revenue this week', :decimalPrecision=>'0', :showNames=>'1', :xAxisName => "Date", :showValues => '0',:bgAlpha => 100, :bgColor => "aaaaaa", :formatNumberScale => '0') do
   xml.categories do
     @date_revenue.each do |date,revenue|
       xml.category(:name =>  "#{date}")
     end
   end
   xml.dataset(:seriesname => "Revenue",:showvalues => "0", :parentYAxis => 'P', :numberPrefix => "Rs.") do
     @date_revenue.each do | date,revenue |
       xml.set( :value => "#{revenue[0]}")
     end
   end
   xml.dataset(:seriesname => "Payment" ,:showvalues => "0", :parentYAxis => 'P', :numberPrefix => "Rs.", :color => '006633') do
     @date_revenue.each do | date,revenue |
       xml.set( :value => "#{revenue[1]}")
     end
   end
   xml.dataset(:seriesname => "Rooms" ,:showvalues => "0", :lineThickness => '4',:parentYAxis => "S", :color => "336699") do
     @date_revenue.each do | date,revenue |
       xml.set( :value => "#{revenue[2]}")
     end
   end

end

