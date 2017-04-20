class Review < ApplicationRecord
    validates :product_id, presence: true
    validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end
