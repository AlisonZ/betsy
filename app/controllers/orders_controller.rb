class OrdersController < ApplicationController
  before_action :check_login, only: [:index, :complete, :incomplete, :show]
  helper_method :user_orders, :user_orders_items

  def index
    @orders = Order.all.order(id: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data @orders.to_csv }
    end
  end


  def complete; end

  def incomplete;end


  def checkout
    @order = Order.find_by_id(session[:order_id])
    if @order.nil? || @order.order_items == []
      flash[:failure] = "Please add an item to your cart to check out"
      redirect_to root_path
    end
    @user = User.find_by_id(session[:user_id])
    if @user != nil
      @order.email = @user.email
    end
  end

  def update #place order
    @order = Order.find_by_id(session[:order_id])
    if @order
      @order.status = "Paid"
      @order.email = order_params[:email]
      @order.name_on_cc = order_params[:name_on_cc]
      @order.cc_number = order_params[:cc_number]
      @order.cc_ccv = order_params[:cc_ccv]
      @order.billing_zip = order_params[:billing_zip]
      @order.address = order_params[:address]
      if @order.save
        # byebug
        session[:order_id] = nil
        @order.order_items.each do |item|
          #updates the stock of each of the products
          item.product.stock = item.product.stock - item.quantity
          item.product.save
        end
      else
        raise
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def check_login
    if !current_user
      flash[:error] = "You must be the owner to access that page"
      redirect_to :root
    end
  end

  def order_params
    params.require(:order).permit(:email, :name_on_cc, :cc_number, :cc_ccv, :billing_zip, :address)
  end


end
