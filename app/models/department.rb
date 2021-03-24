class Department < ApplicationRecord
  has_many :posts

  has_one_attached :cover
end
