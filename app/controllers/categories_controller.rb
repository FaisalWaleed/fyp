class CategoriesController < ApplicationController
  def index
  	@categories  = Category.all
  end

  def new
  	@category = Category.new;
  end
  def create
  	@cat = Category.new(params[:category])
  	@cat.save!
    redirect_to categories_path, :alert => "Category Added Successfully."
  	
  end
end
