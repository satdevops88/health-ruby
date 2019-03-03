class RetailerProduct < ApplicationRecord
  belongs_to :healthiest_category, foreign_key: 'category_id', class_name: 'Category', optional: true
  belongs_to :retailer
  has_many :retailer_product_products, dependent: :destroy
  has_many :recommended_products, through: :retailer_product_products, source: 'product'
end