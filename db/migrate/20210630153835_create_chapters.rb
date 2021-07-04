class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.integer :view_counts
      t.text :image_list
      t.belongs_to :product

      t.timestamps
    end
  end
end
