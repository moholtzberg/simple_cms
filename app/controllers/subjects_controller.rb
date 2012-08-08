class SubjectsController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in
  
  def index
    list
    render("list")
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subjects = Subject.find(params[:id])
  end
  
  def new
    @subjects = Subject.new()
    @subjects_count = Subject.count + 1
  end
  
  def create
    new_position = params[:subjects].delete(:position)
    @subjects = Subject.new(params[:subjects])
    if @subjects.save
      @subjects.move_to_position(new_position)
      flash[:notice] = "#{@subjects.name} has been created"
      redirect_to(:action => "list")
    else
      @subjects_count = Subject.count + 1
      render("new")
    end
  end
  
  def edit
    @subjects = Subject.find(params[:id])
    @subjects_count = Subject.count
  end
  
  def update
    @subjects = Subject.find(params[:id])
    new_position = params[:subjects].delete(:position)
    if @subjects.update_attributes(params[:subjects])
      @subjects.move_to_position(new_position)
      flash[:notice] = "#{@subjects.name} has been updated"
      redirect_to(:action => "list")
    else
      @subjects_count = Subject.count
      render("edit")
    end
  end
  
  def delete
    @subjects = Subject.find(params[:id])
  end
  
  def destroy
    @subjects = Subject.find(params[:id])
    @subjects.move_to_position(nil)
    @subjects.destroy
    flash[:notice] = "#{@subjects.name} has been destroyed"
    redirect_to(:action => "list")
  end
  
end