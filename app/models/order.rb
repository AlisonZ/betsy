class Order < ApplicationRecord
  has_many :order_items
  # Removing this to solve logic problem
  # validates_presence_of :order_items

  def self.to_csv
    attributes = %w(id status )
    CSV.generate( headers: true ) do |csv|
      csv << attributes

      all.each do |order|
        csv << order.attributes.values_at(*attributes)
      end
    end
  end
end
