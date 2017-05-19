class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_admin
    # TODO Update when authorization is in place

    redirect_to root_path unless params[:logged_in]
  end
end
