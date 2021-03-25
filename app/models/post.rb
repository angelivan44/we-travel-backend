class Post < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :likes ,as: :likeable
  has_many :comments ,as: :commentable

  has_many_attached :images

  validates :title, :body, presence: true
  validates :title, length: { maximum: 140 }
  validates :body, length: { maximum: 10000 }
  validates :images, presence: true

  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0
end
