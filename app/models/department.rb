class Department < ApplicationRecord
  has_many :posts ,dependent: :destroy
  has_one_attached :cover ,dependent: :destroy

  def service_url
    if cover.attached?
      Rails.application.routes.default_url_options[:host] = 'https://travel-blog-cp.herokuapp.com'
      return  Rails.application.routes.url_helpers.url_for(cover)
    else
      return ""
    end
  end
end
