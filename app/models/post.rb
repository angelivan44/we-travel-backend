class Post < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :likes
  has_many :comments

  has_many_attached :images

  validates :title, :body, presence: true
  validates :title, length: { maximum: 140 }
  validates :body, length: { maximum: 10000 }
  validates :images, presence: true

  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0
end
