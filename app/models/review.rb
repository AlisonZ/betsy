class Review < ApplicationRecord
    validates :product_id, presence: true
    validates :rating, numericality: { allow_nil: true, only_integer: true, greater_than: 0, less_than: 6 }
end
