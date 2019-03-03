class Product < ApplicationRecord
  acts_as_paranoid
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :brand, optional: true
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :retailer_product_products, dependent: :destroy
  has_many :retailer_products, through: :retailer_product_products

  validates :name, presence: true, uniqueness: true

  def self.create_from_remote_product(remote_product)
    product = find_by(asin: remote_product.asin)
    if !product
      ActiveRecord::Base.transaction do
        brand = Brand.find_or_create_by(name: remote_product.brand)
        product = create(
          amazon_price: remote_product.price,
          asin: remote_product.asin,
          brand: brand,
          image_src: remote_product.images.thumbnail,
          name: remote_product.name,
          teaser: remote_product.teaser
        )

        retailer = Retailer.find_or_create_by(name: Retailer::RETAILER_NAME_AMAZON)
        remote_product.categories.each do |categories|
          next unless categories.size > 2
          category = Category.find_or_create_by(name: categories.last)
          ProductCategory.find_or_create_by(category: category, product: product)
          RetailerCategory.find_or_create_from_tree(categories, healthiest_category: category, retailer: retailer)
        end
      end
    end

    product
  end
end
