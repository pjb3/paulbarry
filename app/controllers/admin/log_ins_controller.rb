class Admin::LogInsController < Admin::BaseController
  skip_before_action :require_admin

  def create
    user = User.find_by(username: params[:username])
    if user.try(:password_matches?, params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      admin_after_log_in_path = session[:admin_after_log_in_path] || admin_root_path
      session[:admin_after_log_in_path] = nil
      redirect_to admin_after_log_in_path
    else
      @error = "Log In Failed"
      render "new"
    end
  end
end
