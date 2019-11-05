class DarkskyWeatherService
  def self.forecast(location)
    # antipode_data = antipode_location_data(location)
    anti_lat = location[:data][:attributes][:lat]
    anti_long = location[:data][:attributes][:long]
    latlng = "#{anti_lat}, #{anti_long}"
    # google_response = google_data(location = nil, latlng)
    # city = google_response[:results][2][:formatted_address]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{anti_lat},#{anti_long}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
