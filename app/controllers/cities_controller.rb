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

    if params[:commit] == 'Tag'
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
    @data = Collection.all
    @str = params[:text].to_s
    @data.each do |f|     
      @temp = Collection.find_by_name(f.name).category.color
      @str = @str.gsub(/(#{f.name})/i, '<mark style="background-color:'+@temp+'  ">'+f.name+'</mark>')
      @str = @str.gsub(/((0?[13578]|10|12)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))/, '<mark>'+'\0'+'</mark>')
      @str = @str.gsub(/((31(?! (FEB|APR|JUN|SEP|NOV)))|((30|29)(?! FEB))|(29(?= FEB (((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])-(JAN|FEB|MAR|MAY|APR|JUL|JUN|AUG|OCT|SEP|NOV|DEC)-((1[6-9]|[2-9]\d)\d{2})/, '<mark>'+'\0'+'</mark>')
      @str = @str.gsub(/(?=\d)(?:(?!(?:(?:0?[5-9]|1[0-4])(?:\.|-|\/)10(?:\.|-|\/)(?:1582))|(?:(?:0?[3-9]|1[0-3])(?:\.|-|\/)0?9(?:\.|-|\/)(?:1752)))(31(?!(?:\.|-|\/)(?:0?[2469]|11))|30(?!(?:\.|-|\/)0?2)|(?:29(?:(?!(?:\.|-|\/)0?2(?:\.|-|\/))|(?=\D0?2\D(?:(?!000[04]|(?:(?:1[^0-6]|[2468][^048]|[3579][^26])00))(?:(?:(?:\d\d)(?:[02468][048]|[13579][26])(?!\x20BC))|(?:00(?:42|3[0369]|2[147]|1[258]|09)\x20BC))))))|2[0-8]|1\d|0?[1-9])([-.\/])(1[012]|(?:0?[1-9]))\2((?=(?:00(?:4[0-5]|[0-3]?\d)\x20BC)|(?:\d{4}(?:$|(?=\x20\d)\x20)))\d{4}(?:\x20BC)?)(?:$|(?=\x20\d)\x20))?((?:(?:0?[1-9]|1[012])(?::[0-5]\d){0,2}(?:\x20[aApP][mM]))|(?:[01]\d|2[0-3])(?::[0-5]\d){1,2})?/, '<mark>'+'\0'+'</mark>')
      @str = @str.gsub(/((31(?!\ (Feb(ruary)?|Apr(il)?|June?|(Sep(?=\b|t)t?|Nov)(ember)?)))|((30|29)(?!\ Feb(ruary)?))|(29(?=\ Feb(ruary)?\ (((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])\ (Jan(uary)?|Feb(ruary)?|Ma(r(ch)?|y)|Apr(il)?|Ju((ly?)|(ne?))|Aug(ust)?|Oct(ober)?|(Sep(?=\b|t)t?|Nov|Dec)(ember)?)\ ((1[6-9]|[2-9]\d)\d{2})/, '<mark>'+'\0'+'</mark>')

    end
  end



  def data

  require 'addressable/uri'

  apikey = "AIzaSyBlwk5eKfI3pzit3zF2hZOJoB21cJojfMw"
  query = [{'id' => nil, 'name' => nil, 'type' => '/location/country'}]
  l = 200
  url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
  url.query_values = {
        'query' => query.to_json,
        'key'=> apikey,
        'lang' => "/lang/en",
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

