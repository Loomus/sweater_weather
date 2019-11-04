class Api::V1::AntipodeController < ApplicationController
  def index
    location = params[:location]
    antipode_weather_data = AntipodeWeatherService.antipode_weather_data(location)
    antipode = Antipode.new(antipode_weather_data, location)
    antipode.create_antipode_data
    weather_for_antipode_city = AntipodeSerializer.new(antipode).serializable_hash
    render json: weather_for_antipode_city
  end
end
