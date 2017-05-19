module Admin
  class SessionsController < ApplicationController
    def create
      if Administrator.authenticate(params[:session][:username], params[:session][:password])
        session[:current_admin_id] = Administrator.find_by(username: params[:session][:username]).id
        flash[:notice] = "You have successfully logged in."
        redirect_to root_url
      else
        flash[:error] = "You have entered the wrong credentials"
        redirect_to root_url
      end
    end

    def destroy
      session[:current_admin_id] = nil
      flash[:notice] = "You have successfully logged out."
      redirect_to root_url
    end
  end
end
