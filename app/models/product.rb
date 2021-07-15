class Product < ApplicationRecord
  has_many :chapters
  belongs_to :category
  has_many :comments
end
