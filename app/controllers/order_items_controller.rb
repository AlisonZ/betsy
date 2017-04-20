class OrderItemsController < ApplicationController
  def create
    @item = OrderItem.new
    @item.product_id = params[:id]
    @order ||= Order.new
    @item.order = @order
    @order.order_items << @item
    #get quantity from show view!
  end
end
