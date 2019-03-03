class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :retailer_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
