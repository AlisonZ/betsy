class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_order_items, :total_items_in_cart
  helper_method :render_404




  def render_404
    render file: "#{ Rails.root }/public/404.html", status: 404
  end

  private

  def current_user
    @logged_in_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_order_items
    if session[:order_id]
      return Order.find_by_id(session[:order_id])
    else
      return false
    end
  end

  def total_items_in_cart
    total = 0
    if current_order_items
      current_order_items.order_items.each do |item|
        total += item.quantity
      end
    end
    return total
  end


end
