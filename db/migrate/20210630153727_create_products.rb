class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :thumbnail_url
      t.integer :current_view_counts
      t.integer :view_count
      t.string :short_description
      t.string :current_chapter
      t.belongs_to :category

      t.timestamps
    end
  end
end
