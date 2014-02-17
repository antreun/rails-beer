class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 1.week) { fetch_places_in(city) }
  end

  def self.place(place_id)
    Rails.cache.fetch(place_id, :expires_in => 1.week) { fetch_place(place_id) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_place(place_id)
    #url = "http://beermapping.com/webservice/locquery/#{ key }/"
    #url += "#{id}"
    url = "http://beermapping.com/webservice/locquery/71b805e235889c824b7aeb51f38045d3/#{place_id}"

    response = HTTParty.get "#{url}"
    
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    #Settings.beermapping_apikey
    ENV['APIKEY']
  end
end
