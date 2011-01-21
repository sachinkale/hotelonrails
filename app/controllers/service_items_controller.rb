class ServiceItemsController < ApplicationController

  def add_service
    @service_item = ServiceItem.new(params[:service_item])
    if @service_item.save!
      respond_to do |format|
        format.html { redirect_to "/checkins"}
        format.js
      end
    end
  end

  
  def delete_service
    @service_item = ServiceItem.find(params[:delete_service_item_id])
    @checkin = @service_item.checkin
    @service_item.destroy
    respond_to do |format|
      format.js
    end
  end
end
