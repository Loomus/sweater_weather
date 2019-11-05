class DarkskyWeatherService
  def self.forecast(location)
    lat = location[:lat]
    long = location[:long]
    response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{lat},#{long}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
