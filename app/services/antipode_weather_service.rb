class AntipodeWeatherService
  def self.antipode_weather_data(location)
    location_data = location_data(location)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]

    response = Faraday.get("http://amypode.herokuapp.com/api/v1/antipodes?lat=#{lat}&long=#{lng}") do |f|
      f.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end

    antipode_data = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.location_data(location)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params[:address] = location
      f.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
