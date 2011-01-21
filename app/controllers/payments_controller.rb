class PaymentsController < ApplicationController

  def add_payment
    @payment = Payment.new(params[:payment])
    if @payment.save!
      respond_to do |format|
        format.html { redirect_to "/checkins" }
        format.js
      end
    end
  end

  def delete_payment
  end

end
