class AccessController < ApplicationController

  layout 'admin'

  # only vs except is like blacklisting vs whitelisting
  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]

  def menu
    # Display text and links
  end

  def login
    # Login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You are now logged in"
      redirect_to(admin_path)
    else
      flash.now[:notice] = "Username and / or password is incorrect"
      render('login')
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out Successfully"
    redirect_to(access_login_path)
  end

end
