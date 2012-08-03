class DemoController < ApplicationController
  
  def index
    #redirect_to({:action => 'hello'})
    @timestodo = ['First', 'Second', 'Third']
    @id = params[:id].to_i
    @page = params[:page].to_i
  end
  
  def hello
    render('index.html.erb')
  end
  
  def escape_output
  end
  
end
