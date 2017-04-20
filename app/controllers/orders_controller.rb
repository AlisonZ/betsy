class OrdersController < ApplicationController
  def checkout
    @order = Order.find_by_id(session[:order_id])
  end
end
