class PagesController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in
  before_filter :find_subject
  
  def index
    list
    render("list")
  end
  
  def list
    @pages = Page.sorted.where(:subject_id => @subject.id)
  end
  
  def show
    @pages = Page.find(params[:id])
  end
  
  def new
    @pages = Page.new(:subject_id => @subject.id)
    @pages_count = @subject.pages.count + 1
    @subjects = Subject.all.collect {|s| [s.name, s.id]}
  end
  
  def create
    @pages = Page.new(params[:pages])
    if @pages.save
      flash[:notice] = "#{@pages.name} has been created"
      redirect_to(:action => "list", :subject_id => @pages.subject.id)
    else
      @pages_count = Page.count + 1
      @subjects = Subject.all.collect {|s| [s.name, s.id]}
      render("new")
    end
  end
  
  def edit
    @pages = Page.find(params[:id])
    @pages_count = @subject.pages.count
    @subjects = Subject.all.collect {|s| [s.name, s.id]}
  end
  
  def update
    @pages = Page.find(params[:id])
    if @pages.update_attributes(params[:pages])
      flash[:notice] = "#{@pages.name} has been updated"
      redirect_to(:action => "list", :subject_id => @pages.subject.id)
    else
      @pages_count = @subject.pages.count
      @subjects = Subject.all.collect {|s| [s.name, s.id]}
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
    redirect_to(:action => "list", :subject_id => @pages.subject.id)
  end
  
  private
  
  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end
  
end