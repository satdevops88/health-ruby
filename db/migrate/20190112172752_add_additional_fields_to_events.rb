class AddAdditionalFieldsToEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :subject, :text
  	add_column :events, :page_number, :integer
  end
end
