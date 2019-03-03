class CreateAmazonKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :amazon_keywords do |t|
      t.string :text, null: false
    end

    add_index :amazon_keywords, :text
  end
end
