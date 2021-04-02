class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_token
  has_secure_password

  has_many :follows 

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :posts ,dependent: :destroy
  has_many :likes , dependent: :destroy
  has_many :comments , dependent: :destroy

  has_one_attached :avatar , dependent: :destroy
  has_one_attached :cover , dependent: :destroy

  attribute :role, :string, default: "user"
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def invalidate_token
    update(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end

  def avatar_url
    if avatar.attached?
      Rails.application.routes.default_url_options[:host] = 'https://travel-blog-cp.herokuapp.com'
      return  Rails.application.routes.url_helpers.url_for(avatar)
    else
      return ""
    end
  end

  def cover_url
    if cover.attached?
      Rails.application.routes.default_url_options[:host] = 'https://travel-blog-cp.herokuapp.com'
      return  Rails.application.routes.url_helpers.url_for(cover)
    else
      return ""
    end
  end

  def followers_data
    followers.map{ |follow| follow.as_json(methods: :avatar_url)}
  end

  def following_data
    following.map{ |follow| follow.as_json(methods: :avatar_url)}
  end

  def  posts_data
    posts.map{ |post| post.as_json(methods: :service_url)}
  end
end
