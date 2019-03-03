class DropAmazonKeyword < ActiveRecord::Migration[5.1]
  def change
    drop_table :amazon_keywords
  end
end
