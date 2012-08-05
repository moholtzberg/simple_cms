class AdminUsersController < ApplicationController
  
  layout "admin"
  
  def index
    list
    render("list")
  end
  
  def list
    @admin_users = AdminUser.all
  end
  
  def show
    @admin_users = AdminUser.find(params[:id])
  end

  def new
    @admin_users = AdminUser.new(params[:admin_user])
  end
  
  def create
    @admin_users = AdminUser.new(params[:admin_users])
    if @admin_users.save
      flash[:notice] = "#{@admin_users.username} has been created!"
      redirect_to(:action => "list")
    else
      render("new")
    end
  end

  def edit
    @admin_users = AdminUser.find(params[:id])
  end
  
  def update
    @admin_users = AdminUser.find(params[:id])
    if @admin_users.update_attributes(params[:admin_users])
      flash[:notice] = "#{@admin_users.username} has been updated!"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def delete
    @admin_users = AdminUser.find(params[:id])
  end
  
  def destroy
    @admin_users = AdminUser.find(params[:id])
    @admin_users.destroy
    flash[:notice] = "#{@admin_users.username} has been destroyed"
    redirect_to(:action => "list")
  end
  
end
