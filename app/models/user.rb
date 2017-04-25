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

  def self.create_from_github(auth_hash)
        user = User.new
        user.uid = auth_hash['uid']
        user.provider = auth_hash['provider']
        user.username = auth_hash['info']['nickname']
        user.email = auth_hash['info']['email']
        user.save ? user : nil
    end
end
