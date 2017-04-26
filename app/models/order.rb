class Order < ApplicationRecord
  has_many :order_items
  # Removing this to solve logic problem
  # validates_presence_of :order_items

  # def self.user_purchased_orders(user_email)
  #   @user_purchases = where(email: user_email)
  # end
  #
  # def purchases_total(user_email)
  #   user_purchased_orders(user_email)
  #   total = 0.0
  #   @user_purchases.each do |order|
  #     total += order.total
  #   end
  #   return total
  # end

  #not currently using in working version
  # def user_products
  #   @user_products = Product.where(user_id: current_user.id)
  # end

  # def self.user_orders_items(user)
  #   @order_items = []
  #   user.products.each do |product|
  #      if product.order_items != []
  #        @order_items << product.order_items
  #      end
  #   end
  #   @order_items.flatten!
  # end

  def user_orders_items
    order_items = []
    current_user.products.each do |product|
      if product.order_items != []
        order_items << product.order_items
      end
    end
    return order_items.flatten!
  end

  def user_orders
      order_items = user_orders_items
      user_orders = {}
      order_items.map {|item| user_orders[item.order_id] = item.order}
      return user_orders.values
  end

  #
  # def user_orders
  #     order_items = user_orders_items
  #     user_orders = {}
  #     order_items.map {|item| user_orders[item.order_id] = item.order}
  #     return user_orders.values
  # end


  def user_status_orders(status)
      return current_user.user_orders.select {|order| order.status == status }
  end

  def user_total
    if self.user_orders_items != nil
      total = 0.00
      self.user_orders_items.each do |item|
        total += item.subtotal
      end
      return total.round(2)
    else
      return 0
    end
  end

  def user_status_total(status)
    if current_user.user_orders_items
      total = 0.00
      current_user.user_orders_items.each do |item|
        if item.ship_status == status
          total += item.subtotal
        end
      end
      return total.round(2)
    else
      return 0
    end
  end

  # def self.order_user_orders_items(user, order)
  #   @order_user_orders_items = user_order_items(user).where(id: order)
  # end

  # def self.to_csv
  #   attributes = %w(id status )
  #   CSV.generate( headers: true ) do |csv|
  #     csv << attributes
  #
  #     all.each do |order|
  #       csv << order.attributes.values_at(*attributes)
  #     end
  #   end
  # end

  def total
    total = 0.00
    #accesses the subtotal of each of the order items
    order_items.each do |item|
      total += item.subtotal
    end
    return total.round(2)
  end


  def products
    items = order_items
    products = items.map { |item| item.product }
    return products
  end

end
