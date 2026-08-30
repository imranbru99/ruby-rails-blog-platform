module Admin
  class DashboardController < BaseController
    def index
      @post_count = Post.count
      @published_count = Post.published.count
      @draft_count = Post.draft.count
      @category_count = Category.count
      @recent_posts = Post.recent.includes(:category).limit(6)
    end
  end
end
