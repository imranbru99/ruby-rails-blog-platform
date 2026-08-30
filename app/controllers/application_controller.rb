class ApplicationController < ActionController::Base
  before_action :load_nav_categories
  helper_method :current_admin, :admin_signed_in?

  private

  def load_nav_categories
    @nav_categories = Category.order(:name)
  end

  def current_admin
    @current_admin ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end

  def admin_signed_in?
    current_admin.present?
  end
end
