class Order < ApplicationRecord
  has_many :order_items
  # Removing this to solve logic problem
  # validates_presence_of :order_items
end
