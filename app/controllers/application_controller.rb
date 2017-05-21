class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_account

  def require_account
      redirect_to new_session_path unless current_account
  end

  def current_account
    @current_account ||= session[:current_account_id] &&
      Account.find_by(id: session[:current_account_id])
  end

  def require_admin
    unless current_account && current_account.admin
      redirect_to root_path
    end
  end
end
