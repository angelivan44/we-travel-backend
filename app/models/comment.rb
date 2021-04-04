class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true , counter_cache: :comments_count
  has_many :likes , as: :likeable ,dependent: :destroy
  has_many :comments ,as: :commentable , dependent: :destroy

  validates :body, presence: true, length: { maximum: 500 }
  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0

end
