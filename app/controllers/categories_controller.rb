class CategoriesController < ApplicationController
  def show
    @category = Category.find_by!(slug: params[:slug])
    @posts = @category.published_posts.includes(:category, :rich_text_body)
    @categories = Category.order(:name)
  end
end
