class Api::V1::AntipodeController < ApplicationController
  def index
    location = params[:location]
    # render json: AnitpodeSerializer.new(
    #   AntipodeFacade.new(params[:location])
    # )
    # forecast_data = WeatherService.forecast_data(location)
    # binding.pry
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params[:address] = location
      f.params[:key] = ENV['GOOGLE_API_KEY']
    end

  location_data = JSON.parse(response.body, symbolize_names: true)
  lat = location_data[:results].first[:geometry][:location][:lat]
  lng = location_data[:results].first[:geometry][:location][:lng]
  response = Faraday.get("http://amypode.herokuapp.com/api/v1/antipodes?lat=#{lat}&long=#{lng}")
  # binding.pry
  end
end
