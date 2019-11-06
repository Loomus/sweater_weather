class ForecastsFacade
  attr_reader :id
  def initialize(location)
    @location = location
    @id = nil
  end

  def city_weather
    forecast_data = WeatherService.forecast_data(@location)
    forecast = Forecast.new(forecast_data, @location)
    forecast.add_all_weather_data
    forecast.city_weather
  end
end
