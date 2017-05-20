module Admin
  class SessionsController < ApplicationController
    def new
    end

    def create
      admin = Administrator.authenticate(params[:session][:username], params[:session][:password])
      if admin
        session[:current_admin_id] = admin.id
        flash[:notice] = "You have successfully logged in."
        redirect_back(fallback_location: root_path)
      else
        flash[:error] = "You have entered the wrong credentials"
        redirect_back(fallback_location: root_path)
      end
    end

    def destroy
      session[:current_admin_id] = nil
      flash[:notice] = "You have successfully logged out."
      redirect_back(fallback_location: root_path)
    end
  end
end
