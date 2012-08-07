class SectionsController < ApplicationController
  
  layout "admin"
  
  before_filter :confirm_logged_in
  
  before_filter :find_page
  
  after_filter :audit_section_edits, :only => [:create, :update]
  
  def index
    list
    render("list")
  end
  
  def list
    @sections = Section.sorted.where(:page_id => @page.id)
  end
  
  def show
    @sections = Section.find(params[:id])
  end
  
  def new
    @sections = Section.new({:page_id => @page.id})
    @sections_size = @page.sections.count + 1
    @pages = Page.all.collect {|p| [p.name, p.id]}
  end
  
  def create
    @sections = Section.new(params[:sections])
    if @sections.save
      flash[:notice] = "#{@sections.name} has been created"
      redirect_to(:action => "list", :page_id => @sections.page.id)
    else
      @user = @user_id
      @sections_size = @page.sections.count + 1
      @pages = Page.all.collect {|p| [p.name, p.id]}
      render("new")
    end
  end
  
  def edit
    @sections = Section.find(params[:id])
    @sections_size = @page.sections.count
    @pages = Page.all.collect {|p| [p.name, p.id]}
  end
  
  def update
    @sections = Section.find(params[:id])
    if @sections.update_attributes(params[:sections])
      # SectionEdit.create(:admin_user_id => @user_id, :section_id => @sections.id, :summary => @sections.content)
      flash[:notice] = "#{@sections.name} has been updated"
      redirect_to(:action => "list", :page_id => @sections.page.id)
    else
      @sections_size = @page.sections.count
      @pages = Page.all.collect {|p| [p.name, p.id]}
      render("edit")
    end
  end
  
  def delete
    @sections = Section.find(params[:id])
  end
  
  def destroy
    @sections = Section.find(params[:id])
    @sections.destroy
    flash[:notice] = "#{@sections.name} has been destroyed"
    redirect_to(:action => "list", :page_id => @sections.page.id)
  end
  
  private
  
  def find_page
    if params[:page_id]
      @page = Page.find_by_id(params[:page_id])
    end
  end
  
  def audit_section_edits
    SectionEdit.create(:admin_user_id => @user_id, :section_id => @sections.id, :summary => @sections.content)
  end
  
end