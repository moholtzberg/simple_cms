class AccessController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
    menu
    render("menu")
  end
  
  def menu
    @last_subjects = Subject.limit(5).offset(0).order("subjects.id DESC")
  end

  def login
  end
  
  def attempt_login
    authorized_user = AdminUser.authenticate(params[:username], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      session[:expires] = Time.now + 300
      flash[:notice] = "You have been logged in successfully!"
      redirect_to(:action => "menu")
    else
      flash[:notice] = "Invalid Username or Password, please try again"
      redirect_to(:action => "login")
    end
  end
  
  def logout
    session[:user_id] = nil
    session[:username] = nil
    session[:expires] = nil
    flash[:notice] = "You have been logged out successfully!"
    redirect_to(:action => "login")
  end
  
end