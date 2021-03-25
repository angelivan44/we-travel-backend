class Post < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :likes ,as: :likeable
  has_many :comments ,as: :commentable

  has_many_attached :images

  validates :title, :body, presence: true
  validates :title, length: { maximum: 140 }
  validates :body, length: { maximum: 10000 }

  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0

  def service_url
    images.map{ |image| (url_for(image)).as_json }
  end
  def url_for(data)
    Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
    Rails.application.routes.url_helpers.url_for(data)
  end
end
