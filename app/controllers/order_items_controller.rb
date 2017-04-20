class OrderItemsController < ApplicationController
  def create
    @item = OrderItem.new
    @item.quantity = item_params[:quantity]
    @item.product_id = params[:id]
    @order ||= Order.create
    @item.order_id = @order.id
    @order.order_items << @item
    #get quantity from show view!
    redirect_to cart_path
  end

  def cart
    #have to be attached to Session, otherwise all of the
    #order items ever will be shown - And how does this work if
    #the user has not logged in??
    @items = OrderItem.all
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity)
  end

end
