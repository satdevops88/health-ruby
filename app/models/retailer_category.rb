# TODO - doing way to much work to get descendats, etc.
# Questionable whether this is the right data format for storing this data

class RetailerCategory < ApplicationRecord
  belongs_to :retailer, inverse_of: :categories
  belongs_to :healthiest_category, foreign_key: 'category_id', class_name: 'Category', optional: true
  belongs_to :parent, class_name: 'RetailerCategory', inverse_of: :children, optional: true
  has_many :children, foreign_key: 'parent_id', class_name: 'RetailerCategory'

  before_save :set_full_name

  validates :name, presence: true

  def self.fuzzy_find_from_tree(categories:, retailer:)
    # TODO - get from cache here for quick access
    category = nil

    # Go as far in the tree as we are able, but still return something even
    # if we don't have the leaf category
    categories.each do |category_name|
      if c = find_by(name: category_name, parent: category, retailer: retailer)
        category = c
      end
    end

    category
  end

  # TODO - could leverage full_name here now that it's in the db
  def self.find_from_tree(categories, retailer:)
    parent = nil

    for idx in (0...categories.size)
      category = find_by(name: categories[idx], retailer: retailer, parent: parent)
      if !category
        return false
      end
      parent = category
    end

    category
  end

  # Takes in an array of category strings
  # (i.e. ['Health', 'Skin Care', 'Lotion']) and creates the category
  # hierarchy. Only the leaf category will be tied to the provided
  # healthiest category
  def self.find_or_create_from_tree(categories, healthiest_category:, retailer:)
    parent = nil

  	for idx in (0...categories.size)
      category = find_or_create_by(name: categories[idx], retailer: retailer, parent: parent)
      parent = category
  	end

    category.update_attributes(healthiest_category: healthiest_category)
  end

  def all_descendants(descendants = [])
    if children.empty?
      return []
    end

    descendants.concat(children)
    children.each { |c| c.all_descendants(descendants) }

    descendants
  end

  def to_s
    full_name
  end

  def to_tree
    tree = [self.name]
    c = self
    while c.parent
      c = c.parent
      tree = [c.name] + tree
    end
    tree
  end

  private

    def set_full_name
      str = name
      c = self
      while c.parent
        c = c.parent
        str = "#{c.name} > #{str}"
      end
      self.full_name = str
    end

end