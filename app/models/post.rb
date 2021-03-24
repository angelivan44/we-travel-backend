class Post < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :likes
  has_many :comments
end
