class PagesController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in
  
  def index
    list
    render("list")
  end
  
  def list
    @pages = Page.order("pages.position ASC")
  end
  
  def show
    @pages = Page.find(params[:id])
  end
  
  def new
    @pages = Page.new(params[:pages])
    @pages_count = Page.count + 1
    @subjects = Subject.all.collect {|s| [s.name, s.id]}
    puts "************  #{@subjects.inspect}  ****************"
  end
  
  def create
    @pages = Page.new(params[:pages])
    if @pages.save
      flash[:notice] = "#{@pages.name} has been created"
      redirect_to(:action => "list")
    else
      @pages_count = Page.count + 1
      @subjects = Subject.all.collect {|s| [s.name, s.id]}
      render("new")
    end
  end
  
  def edit
    @pages = Page.find(params[:id])
    puts "++++ #{Page.count}  ++++"
    @pages_count = Page.count
    @subjects = Subject.all.collect {|s| [s.name, s.id]}
    puts "************  #{@pages_count.inspect}  ****************"
  end
  
  def update
    @pages = Page.find(params[:id])
    if @pages.update_attributes(params[:pages])
      flash[:notice] = "#{@pages_count.inspect} has been updated"
      redirect_to(:action => "list")
    else
      puts "++++ #{Page.count}  ++++"
      @pages_count = Page.count
      @subjects = Subject.all.collect {|s| [s.name, s.id]}
      puts "************  #{@pages_count.inspect}  ****************"
      render("edit")
    end
  end
  
  def delete
    @pages = Page.find(params[:id])
  end
  
  def destroy
    @pages = Page.find(params[:id])
    @pages.destroy
    flash[:notice] = "#{@pages.name} has been destroyed"
    redirect_to(:action => "list")
  end
  
end