class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def confirm_logged_in
    puts "!!!!!!!!!session is #{session[:expires]}"
    puts "!!!!!!!!!time    is #{Time.now}"
    puts "!!!!!!!!!time    is #{session[:user_id]}"
    unless session[:expires] != nil && session[:expires] > Time.now && session[:user_id] != nil
      flash[:notice] = "Please log in!"
      redirect_to(:controller => "access", :action => "login")
      return false
    else
      session[:expires] = Time.now + 300
      return true
    end
  end
  
end
