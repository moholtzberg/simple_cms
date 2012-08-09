class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def confirm_logged_in
    unless session[:expires] != nil && session[:expires] > Time.now && session[:user_id] != nil
      flash[:notice] = "Please log in!"
      redirect_to(:controller => "access", :action => "login")
      return false
    else
      session[:expires] = Time.now + 300
      @user_id = session[:user_id]
      @user = AdminUser.find(@user_id)
      @username = AdminUser.find(@user_id).username
      return true
    end
  end
  
end
