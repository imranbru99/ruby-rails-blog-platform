module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :require_admin

    private

    def require_admin
      unless admin_signed_in?
        redirect_to admin_login_path, alert: "Sign in to open the admin panel."
      end
    end
  end
end
