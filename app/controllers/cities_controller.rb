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

  	#url = "https://www.googleapis.com/language/translate/v2?key=AIzaSyBlwk5eKfI3pzit3zF2hZOJoB21cJojfMw&source=en&target=ur&q="+params[:english]
  	#return render json: params[:text][:english]
    
    @a = City.all
    @str = params[:text][:english]
     @a.each do |f|     
      @str = @str.gsub(/(#{f.english})/i, '<mark>'+f.english+'</mark>')
     end

    # @str =@str.gsub(f.english,'<mark>f.english</mark>')
   	#encoded_url = URI.encode(url)
   #	@response = HTTParty.get("http://rubygems.org/api/v1/versions/httparty.json")
		# puts @response.inspect
	end

end

