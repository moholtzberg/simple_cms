class PublicController < ApplicationController
  
  layout "public"
  
  def index
  end

  def show
    @page = Page.where(:subject_id => params[:subject], :permalink => params[:permalink], :visible => true).first
    redirect_to(:action => "index") unless @page
  end
end
