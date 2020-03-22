class Admin::BaseController < ApplicationController
  before_action :require_admin

  layout "admin"

  private

  def auth_token
    cookies[:auth_token]
  end

  def require_admin
    unless current_user
      redirect_to_admin_log_in "Please log in to continue"
    end
  end

  def redirect_to_admin_log_in(error)
    session[:admin_after_log_in_path] = request.fullpath
    redirect_to admin_log_in_path, error: error
  end

  helper_method def current_user
    if defined? @current_user
      @current_user
    else
      @current_user = begin
        if auth_token.present?
          if user = User.find_by_auth_token(auth_token)
            user
          else
            logger.warn "invalid_auth_token auth_token=#{auth_token} request_id=#{request.uuid}"
            nil
          end
        end
      end
    end
  end

  helper_method def current_user_id
    current_user.try(:id)
  end

  helper_method def logged_in?
    current_user_id.present?
  end
end
