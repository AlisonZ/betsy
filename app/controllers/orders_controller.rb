class OrdersController < ApplicationController
  def create
    @order = Order.new
  end
end
