class Post < ApplicationRecord
  include Sluggable

  belongs_to :category
  has_rich_text :body
  has_one_attached :cover_image

  validates :title, presence: true
  validates :excerpt, presence: true, length: { maximum: 400 }
  validates :body, presence: true

  scope :published, -> {
    where(published: true).where("published_at IS NULL OR published_at <= ?", Time.current)
  }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(Arel.sql("COALESCE(published_at, created_at) DESC")) }
  scope :draft, -> { where(published: false) }

  before_save :stamp_published_at

  def reading_minutes
    words = body.to_plain_text.to_s.split.size
    [ (words / 200.0).ceil, 1 ].max
  end

  def related_posts(limit: 3)
    category.posts.published.recent.where.not(id: id).limit(limit)
  end

  private

  def stamp_published_at
    self.published_at = Time.current if published? && published_at.blank?
  end
end
