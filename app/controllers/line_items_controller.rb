class LineItemsController < ApplicationController
  before_filter :authenticate_user!

  def get_line_items
    @line_item = LineItem.find(params[:id])
    
    respond_to do |format|
      format.js
    end

  end

  def edit_line_item
    @line_item = LineItem.find(params[:id])

    @checkin = @line_item.checkin

    params[:line_item]["tax"] = 0 if params[:line_item]["tax"] == "" 
    params[:line_item]["rate"] = 0 if params[:line_item]["rate"] == ""
    params[:line_item]["extraperson"] = 0 if params[:line_item]["extraperson"] == ""
    Time.zone = APP_CONFIG['hotel_time_zone']

    fromdate = Time.local(params[:line_item1]["fromdate(1i)"].to_i,params[:line_item1]["fromdate(2i)"].to_i,params[:line_item1]["fromdate(3i)"].to_i,params[:line_item1]["fromdate(4i)"].to_i,params[:line_item1]["fromdate(5i)"].to_i)



    if fromdate.future?
      @error = "Cannot Set date / time greater than today"
    else
      params[:line_item][:fromdate] = fromdate
      if @line_item.freez
        todate = Time.local(params[:line_item1]["todate(1i)"].to_i,params[:line_item1]["todate(2i)"].to_i,params[:line_item1]["todate(3i)"].to_i,params[:line_item1]["todate(4i)"].to_i,params[:line_item1]["todate(5i)"].to_i) 
        if fromdate > todate
          @error = "Cannot set shift date greater than checkin date"
        else
          @checkin.line_items.where(:fromdate => @line_item.todate)[0].update_attribute(:fromdate, todate)
          params[:line_item][:todate] = todate
        end
      end
    end
    @line_item.update_attributes(params[:line_item]) if @error.nil? or @error == ""
    @checkin.update_fromdate
  end

  def delete_line_item


  end

end
