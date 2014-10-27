class CitiesController < ApplicationController
  def index
  	@city = City.new
  end

  def show
    
  end

  def create
  end

  def new
  end

  def translate
    require 'bing_translator'

    if params[:commit] == 'Location'
      return redirect_to location_cities_path(text: params[:text][:english])
    end

  	#url = "https://www.googleapis.com/language/translate/v2?key=AIzaSyBlwk5eKfI3pzit3zF2hZOJoB21cJojfMw&source=en&target=ur&q="+params[:english]
  	#return render json: params[:text][:english]
    

    #////// working module for database translation/////////////////////////////////////
    # 

     #/////////////////////////////end///////////////////////////////////////////////////

     translator = BingTranslator.new('85ee48d9-d049-486f-bd9d-2996cfab1880', 'kiEYdOYGRcnrJGfDURzqDxxeQdpwpIKMYZcBHRD+p3o=')

     @spanish = translator.translate params[:text][:english], :to => 'ur'



    # @str =@str.gsub(f.english,'<mark>f.english</mark>')
   	#encoded_url = URI.encode(url)
   #	@response = HTTParty.get("http://rubygems.org/api/v1/versions/httparty.json")
		# puts @response.inspect
	end
  def location
    @a = City.all
    @str = params[:text]
    @a.each do |f|     
      @str = @str.gsub(/(#{f.english})/i, '<mark>'+f.english+'</mark>')
    end
  end

end

