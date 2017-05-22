class SessionsController < ApplicationController
  skip_before_action :require_account

  def new
  end

  def create
    account = Account.authenticate(params[:session][:username], params[:session][:password])
    if account
      session[:current_account_id] = account.id
      flash[:notice] = "You have successfully logged in."
      path = account.admin ? admin_contest_path : root_path
      redirect_to path
    else
      flash[:error] = "You have entered the wrong credentials"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    session[:current_account_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end
end
