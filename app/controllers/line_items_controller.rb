class LineItemsController < ApplicationController
  before_filter :authenticate_user!

  def get_line_items
    @line_item = LineItem.find(params[:id])
    
    respond_to do |format|
      format.js
    end

  end

  def edit_line_item
    
  end

  def delete_line_item


  end

end
