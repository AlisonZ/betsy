class Order < ApplicationRecord
  has_many :order_items
  # Removing this to solve logic problem
  # validates_presence_of :order_items

  def self.user_products(user)
    @user_products = Product.where(user_id: user)
  end

  def self.user_orders_items(user)
    user_products(user)
    @order_items = []
    @user_products.each do |product|
       if product.order_items != []
         @order_items << product.order_items
       end
    end
    @order_items.flatten!
  end

  def self.user_orders(user)
      user_orders_items(user)
      @user_orders = {}
      @order_items.map {|item| @user_orders[item.order_id] = item.order}
      return @user_orders.values
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
