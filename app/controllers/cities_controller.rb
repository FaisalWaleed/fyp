class CitiesController < ApplicationController
  def index
  	@city = City.new
  end

  def show
    
  end

  def create
    city = City.new(params[:city])
    city.save!

  end

  def new
    @city = City.new
  end

  def translate
    require 'bing_translator'

    if params[:commit] == 'Location'
      return redirect_to location_cities_path(text: params[:text][:english])
    end

  	#return render json: params[:text][:english]
    
     translator = BingTranslator.new('85ee48d9-d049-486f-bd9d-2996cfab1880', 'kiEYdOYGRcnrJGfDURzqDxxeQdpwpIKMYZcBHRD+p3o=')

     @spanish = translator.translate params[:text][:english], :to => 'ur'
    # @str =@str.gsub(f.english,'<mark>f.english</mark>')
   	#encoded_url = URI.encode(url)
   #	@response = HTTParty.get("http://rubygems.org/api/v1/versions/httparty.json")
		# puts @response.inspect
	end


  def location
    #return render json: params[:text]

    @a = City.all
    @str = params[:text].to_s
    @a.each do |f|     
      @str = @str.gsub(/(#{f.english})/i, '<mark>'+f.english+'</mark>')
    end
  end



  def data

  require 'addressable/uri'

  apikey = "AIzaSyBlwk5eKfI3pzit3zF2hZOJoB21cJojfMw"
  query = [{'id' => nil, 'name' => nil, 'type' => '/location/location'}]
  l = 200
  url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
  url.query_values = {
        'query' => query.to_json,
        'key'=> apikey,
        'id'=> 'ur',
        'limit' => l
    }
  @topic = HTTParty.get(url, :format => :json)
  puts '---'*80
  @topic['result'].each { |toic|
  a = City.new
  a.english = toic['name']
  a.typ = 'country'
  a.save!
}


query = [{'id' => nil, 'name' => nil, 'type' => '/people/person'}]
  l = 200
  url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
  url.query_values = {
        'query' => query.to_json,
        'key'=> apikey,
        'id'=> 'ur',
        'limit' => l
    }
  @top = HTTParty.get(url, :format => :json)
  puts '---'*80
  @top['result'].each { |toic|
  z = People.new
  z.eng_name = toic['name']
  z.save!
}
  # end

  #return render json: topic['property']['/type/object/name']['values'][0]['value']



  # topic_id = '/m/0d6lp'
  # url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/search?query=countries')
  # url.query_values = [{'id': None, 'name': None, 'type': '/astronomy/planet'}]
  # params = {
  #       'query': json.dumps(query),
  #       'key': api_key
  #     }

     
  #    #url = "https://www.googleapis.com/freebase/v1/search?query=countries?&key="+apikey
  #    @response = HTTParty.get(url)
     
  #    puts 'A'*300
  #    @data = JSON.parse(@response.body)['result']
     

  end

  def loc
    @loc = City.all

  end

  def people

    @p = People.all
    
  end


end

