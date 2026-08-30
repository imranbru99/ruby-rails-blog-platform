class Category < ApplicationRecord
  include Sluggable

  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def published_posts
    posts.published.recent
  end
end
