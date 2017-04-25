class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :order_items

  validates :name, uniqueness: true

  validates :name, presence: true
  # validates :user_id, presence: true
  validates :price, presence: true
  SELLING_STATUS = {"Selling" => true, "Retired" => false}

  def sell_status
    if self.selling_status
      "selling"
    else
      "retired"
    end
  end

  def out_of_stock
    if self.stock == 0
      return true
    else
      false
    end
  end

  def selling?
    if self.selling_status == true
      return true
    else
      return false
    end
  end

  def average_rating
    total_ratings = 0
    self.reviews.each do |review|
      total_ratings += review.rating
    end
    average = total_ratings.to_f / self.reviews.count
    return average.round(2)
  end

  # def self.to_csv
  #   attributes = %w(id title description price photo_url stock user_id selling_status )
  #   CSV.generate( headers: true ) do |csv|
  #     csv << attributes
  #
  #     all.each do |product|
  #       csv << product.attributes.values_at(*attributes)
  #     end
  #   end
  # end


end
