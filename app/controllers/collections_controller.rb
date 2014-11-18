class CollectionsController < ApplicationController
  def index
  	@collections = Collection.all
  	
  end

  def new
  end

  def upload
  	@categories = Category.all
  end

  def import
  	file = params[:file]
  	category = Category.find_by_name(params[:category])
  	Collection.import(params[:file], category)
   	redirect_to collections_path 
  end
end
