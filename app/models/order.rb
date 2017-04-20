class Order < ApplicationRecord
  has_many :order_items
  validates_presence_of :order_items
end
