class AntipodeFacade

  def initialize(location)
    @location = location
  end

  def expose_antipode_forecast
    coords = GoogleLocationService.google_data(@location)
    antipode_response = AntipodeLocationService.find(coords)
    antipode_coords = antipode_response[:data][:attributes]
    forecast = DarkskyWeatherService.forecast(antipode_coords)
    city_response = GoogleLocationService.google_data(nil, antipode_coords)
    city = city_response[:results][2][:formatted_address]
    Antipode.new(forecast, @location, city)
  end
end
