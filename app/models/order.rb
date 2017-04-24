class Order < ApplicationRecord
  has_many :order_items
  # Removing this to solve logic problem
  # validates_presence_of :order_items


  def self.user_orders(user)
    # user = session[:user_id].to_i
    @user_products = Product.where(user_id: user)
    @order_items = []
    @user_products.each do |product|
       if product.order_items != []
         @order_items << product.order_items
       end
    end
    @order_items.flatten!

    @user_orders = @order_items.map {|item| item.order}
    return @user_orders
  end


  def self.to_csv
    attributes = %w(id status )
    CSV.generate( headers: true ) do |csv|
      csv << attributes

      all.each do |order|
        csv << order.attributes.values_at(*attributes)
      end
    end
  end

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
