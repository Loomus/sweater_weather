class Api::V1::AntipodeController < ApplicationController
  def index
    location = params[:location]
    coords = GoogleLocationService.google_data(location)
    antipode_response = AntipodeLocationService.find(coords)
    antipode_coords = antipode_response[:data][:attributes]
    forecast = DarkskyWeatherService.forecast(antipode_coords)
    city_response = GoogleLocationService.google_data(nil, antipode_coords)
    city = city_response[:results][2][:formatted_address]
    antipode = Antipode.new(forecast, location, city)
    antipode.create_antipode_data
    weather_for_antipode_city = AntipodeSerializer.new(antipode).serializable_hash
    render json: weather_for_antipode_city
  end
end
