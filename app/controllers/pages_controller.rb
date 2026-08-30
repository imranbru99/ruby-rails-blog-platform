class PagesController < ApplicationController
  def about
    @categories = Category.order(:name)
    @post_count = Post.published.count
    @category_count = Category.count
  end
end
