class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :products

  def self.to_csv
    attributes = %w(id username email)
    CSV.generate( headers: true ) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def orders
    user_orders = Order.where(email: email)
    return user_orders
  end
end
