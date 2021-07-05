class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :view_counts
      t.string :author
      t.text :url
      t.belongs_to :category

      t.timestamps
    end
  end
end
