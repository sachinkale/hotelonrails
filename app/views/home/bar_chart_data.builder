xml= Builder::XmlMarkup.new
 xml.graph(:caption=>'Revenue this week', :decimalPrecision=>'0', :showNames=>'1', :xAxisName => "Date", :showValues => '1',:bgAlpha => 100, :bgColor => "aaaaaa", :formatNumberScale => '0') do
   @date_revenue.each do | date,revenue |
     xml.set(:name => "#{date}", :value => "#{revenue}")
   end
end

