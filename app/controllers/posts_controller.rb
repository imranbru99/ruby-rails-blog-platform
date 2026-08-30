class PostsController < ApplicationController
  def index
    @featured = Post.published.featured.recent.includes(:category, :rich_text_body).first
    @posts = Post.published.recent.includes(:category, :rich_text_body)
    @posts = @posts.where.not(id: @featured.id) if @featured
    @categories = Category.order(:name)
  end

  def show
    @post = Post.published.includes(:category).find_by!(slug: params[:slug])
    @related = @post.related_posts
    @categories = Category.order(:name)
  end
end
