module Admin
  class SessionsController < ApplicationController
    layout "admin_auth"

    def new
      redirect_to admin_root_path if admin_signed_in?
    end

    def create
      admin = AdminUser.find_by(email: params[:email].to_s.strip.downcase)

      if admin&.authenticate(params[:password])
        session[:admin_user_id] = admin.id
        redirect_to admin_root_path, notice: "Welcome back."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:admin_user_id)
      redirect_to admin_login_path, notice: "You have been signed out."
    end
  end
end
