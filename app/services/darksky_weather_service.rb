class DarkskyWeatherService
  def self.antipode_weather_data(location)
    antipode_data = antipode_location_data(location)
    anti_lat = antipode_data[:data][:attributes][:lat]
    anti_long = antipode_data[:data][:attributes][:long]
    latlng = "#{anti_lat}, #{anti_long}"
    google_response = google_data(location = nil, latlng)
    city = google_response[:results][2][:formatted_address]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{anti_lat},#{anti_long}")
    antipode_forecast = JSON.parse(response.body, symbolize_names: true)
  end
end
