class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_admin
    # TODO Update when authorization is in place
    redirect_to root_path unless current_admin
  end

  def current_admin
    @current_admin ||= session[:current_admin_id] &&
      Administrator.find_by(id: session[:current_admin_id])
  end
end
