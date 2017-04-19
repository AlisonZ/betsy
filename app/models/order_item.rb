class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numbericality: { only_integer: true, greater_than: 0 }
end
