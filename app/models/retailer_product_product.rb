class RetailerProductProduct < ApplicationRecord
  belongs_to :product
  belongs_to :retailer_product
end