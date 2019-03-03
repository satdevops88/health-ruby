class CreateAmazonKeywordTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :amazon_keyword_taggings do |t|
      t.references :product
      t.references :amazon_keyword
    end
  end
end
