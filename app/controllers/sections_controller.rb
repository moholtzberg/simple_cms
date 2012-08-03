class SectionsController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in
  
  def index
    list
    render("list")
  end
  
  def list
    @sections = Section.order("sections.position ASC")
  end
  
  def show
    @sections = Section.find(params[:id])
  end
  
  def new
    @sections = Section.new()
    @sections_size = Section.all.count + 1
    @pages = Page
    puts "************  #{@pages.inspect}  ****************"
  end
  
  def create
    @sections = Section.new(params[:sections])
    if @sections.save
      flash[:notice] = "@sections.name has been created"
      redirect_to(:action => "list")
    else
      @sections_size = Section.all.count + 1
      @pages = Page
      render("new")
    end
  end
  
  def edit
    @sections = Section.find(params[:id])
    @sections_size = Section.all.count
    @pages = Page
    puts "************  #{@pages.inspect}  ****************"
  end
  
  def update
    @sections = Section.find(params[:id])
    if @sections.update_attributes(params[:sections])
      flash[:notice] = "@sections.name has been updated"
      redirect_to(:action => "list")
    else
      @sections_size = Section.all.count
      @pages = Page
      render("edit")
    end
  end
  
  def delete
    @sections = Section.find(params[:id])
  end
  
  def destroy
    @sections = Section.find(params[:id])
    @sections.destroy
    flash[:notice] = "@sections.name has been destroyed"
    redirect_to(:action => "list")
  end
  
end