class Post < ApplicationRecord
  belongs_to :user
  belongs_to :department

  has_many :likes ,as: :likeable , dependent: :destroy
  has_many :comments ,as: :commentable , dependent: :destroy

  has_many_attached :images ,dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { maximum: 140 }
  validates :body, length: { maximum: 10000 }

  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0

  def service_url
    images.map{ |image| (url_for(image)).as_json }
  end
  def url_for(data)
    Rails.application.routes.default_url_options[:host] = 'https://travel-blog-cp.herokuapp.com/'
    Rails.application.routes.url_helpers.url_for(data)
  end

  def comments_data
    comments.map{ |comment| comment.as_json(include: [user: {methods: :avatar_url},comments:{include: [user: {methods: :avatar_url},likes:{include: :likes}]},likes:{include: :likes}])}
  end
end
