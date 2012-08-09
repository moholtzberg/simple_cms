class ModelsController < ApplicationController
  
  def index
    list
    render "list"
  end
  
  def list
    @models = Model.active
  end
  
  def show
    @models = Model.find(params[:id])
  end
  
  def edit
    @models = Model.find(params[:id])
  end
  
  def update
    
  end
  
  def delete
    
  end
  
  def destroy
    
  end
  
end
