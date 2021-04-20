class CreateBookCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_categories do |t|
      t.integer :book_id
      t.integer :category_id
    end
  end
end
