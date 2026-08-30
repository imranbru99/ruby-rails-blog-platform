module Sluggable
  extend ActiveSupport::Concern

  RESERVED_SLUGS = %w[
    admin about category categories login logout up assets rails
    posts post pages page
  ].freeze

  included do
    before_validation :assign_slug
    validates :slug, presence: true, uniqueness: { case_sensitive: false }
    validates :slug, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/, message: "must be lowercase letters, numbers, and hyphens" }
    validate :slug_must_not_be_reserved
  end

  def to_param
    slug
  end

  private

  def assign_slug
    source = slug.presence || try(:title) || try(:name)
    self.slug = source.to_s.parameterize
  end

  def slug_must_not_be_reserved
    errors.add(:slug, "is reserved") if RESERVED_SLUGS.include?(slug)
  end
end
