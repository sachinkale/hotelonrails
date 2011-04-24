class PaymentsController < ApplicationController

  def add_payment
    respond_to do |format|
      if params[:payment][:amount] == ""
        @error = "Please enter payment amount!"
      else
         @payment = Payment.new(params[:payment])
         @payment.save!
      end
      format.html { redirect_to "/checkins" }
      format.js

    end
  end

  def delete_payment
    @payment = Payment.find(params[:delete_payment_id])
    @checkin = @payment.checkin
    @payment.destroy
    respond_to do |format|
      format.js
    end
  end


end
