class Product < ApplicationRecord
  has_many :chapters
  belongs_to :category
end
