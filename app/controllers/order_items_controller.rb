class OrderItemsController < ApplicationController
  before_action :create_order, only: [:create]

  def index
    @order_items = OrderItem.all
    respond_to do |format|
        format.html
        format.csv { send_data @order_items.to_csv }
      end
  end

  def create
    @item = OrderItem.new
    @item.quantity = item_params[:quantity]
    @item.product_id = params[:id]
    @item.order_id = @order.id
    if @item.save
      @order.order_items << @item
      redirect_to cart_path
    else
      flash.now[:failure] = "Unable to add to cart at this time"
      redirect_to product_path(params[:id])
    end
  end

  def cart
    @cart_items = OrderItem.where(order_id: session[:order_id])
    @item = OrderItem.find_by_id(params[:id])
    # raise
  end

  def update
    @item = OrderItem.find_by_id(params[:id])
    if @item.update(item_params)
      redirect_to :cart
    else
      flash.now[:error] = "Unable to update quantity of #{@item.product.name} at this time"
      render :cart
    end

  end

  def destroy
    @item = OrderItem.find_by_id(params[:id])
    if @item.destroy
      flash[:success] = "Removed #{@item.product.name} from cart"
      redirect_to :cart

    else
      flash.now[:failure] = "Could not remove #{@item.product.name} from cart at this time. Whoops!"
      render :cart

    end

  end

  private

  def item_params
    params.require(:order_item).permit(:quantity)
  end

  def create_order
    if session[:order_id]
      @order = Order.find_by_id(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
end
