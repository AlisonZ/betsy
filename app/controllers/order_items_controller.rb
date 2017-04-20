class OrderItemsController < ApplicationController
  before_action :create_order, only: [:create]

  def create
    @item = OrderItem.new
    @item.quantity = item_params[:quantity]
    @item.product_id = params[:id]
    @item.order_id = @order.id
    if @item.save
      @order.order_items << @item
      redirect_to cart_path
    end
  end

  def cart
    @cart_items = OrderItem.where(order_id: session[:order_id])
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity)
  end

  def create_order
    if !session[:order_id]
      @order = Order.create
      session[:order_id] = @order.id
    else
      @order = Order.find_by_id(session[:order_id])
    end
  end
end
