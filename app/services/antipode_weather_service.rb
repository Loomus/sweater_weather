class AntipodeWeatherService
  def self.antipode_location_data(location)
    location_data = location_data(location)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]
    response = Faraday.get("http://amypode.herokuapp.com/api/v1/antipodes?lat=#{lat}&long=#{lng}") do |f|
      f.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.antipode_weather_data(location)
    antipode_data = antipode_location_data(location)
    anti_lat = antipode_data[:data][:attributes][:lat]
    anti_long = antipode_data[:data][:attributes][:long]

    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{anti_lat},#{anti_long}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.location_data(location, latlng)
    if location
      response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
        f.params[:address] = location
        f.params[:key] = ENV['GOOGLE_API_KEY']
      end
    elsif latlng
      response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
        f.params[:latlng] = latlng
        f.params[:key] = ENV['GOOGLE_API_KEY']
      end 
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
