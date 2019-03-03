class DropAmazonKeywordTagging < ActiveRecord::Migration[5.1]
  def change
    drop_table :amazon_keyword_taggings
  end
end
