class ProductCategory < ApplicationRecord
  validates_presence_of :product, :category
  validates_uniqueness_of :product, scope: :category, message: "already has that category."

  belongs_to :category
  belongs_to :product
end
