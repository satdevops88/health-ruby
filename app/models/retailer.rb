class Retailer < ApplicationRecord
  has_many :categories, foreign_key: 'retailer_id', class_name: 'RetailerCategory'
  has_many :products, foreign_key: 'retailer_id', class_name: 'RetailerProduct'
  validates :name, presence: true

  RETAILER_NAME_AMAZON = 'Amazon'
  # TODO - ensure these match the names in the database
  RETAILER_DOMAIN_TO_NAME_LOOKUP = {
    'amazon.com' => RETAILER_NAME_AMAZON
  }
end