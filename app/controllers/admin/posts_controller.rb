module Admin
  class PostsController < BaseController
    before_action :set_post, only: %i[edit update destroy]
    before_action :load_categories, only: %i[new create edit update]

    def index
      @posts = Post.recent.includes(:category)
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to admin_posts_path, notice: "Post created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path, notice: "Post deleted."
    end

    private

    def set_post
      @post = Post.find_by(slug: params[:id]) || Post.find(params[:id])
    end

    def load_categories
      @categories = Category.order(:name)
    end

    def post_params
      params.require(:post).permit(
        :title, :slug, :excerpt, :body, :published, :featured,
        :published_at, :category_id, :cover_image
      )
    end
  end
end
