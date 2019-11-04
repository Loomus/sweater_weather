class Api::V1::AntipodeController < ApplicationController
  def index
    location = params[:location]
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params[:address] = location
      f.params[:key] = ENV['GOOGLE_API_KEY']
    end

    location_data = JSON.parse(response.body, symbolize_names: true)
    lat = location_data[:results].first[:geometry][:location][:lat]
    lng = location_data[:results].first[:geometry][:location][:lng]

    response = Faraday.get("http://amypode.herokuapp.com/api/v1/antipodes?lat=#{lat}&long=#{lng}") do |f|
      f.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end

    antipode_data = JSON.parse(response.body, symbolize_names: true)
    anti_lat = antipode_data[:data][:attributes][:lat]
    anti_long = antipode_data[:data][:attributes][:long]

    dark_sky_response = Faraday.get("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{anti_lat},#{anti_long}")

    antipode_response = JSON.parse(dark_sky_response.body, symbolize_names: true)
    antipode = Antipode.new(antipode_response, location)
    antipode.create_antipode_data
    weather_for_antipode_city = AntipodeSerializer.new(antipode).serializable_hash
    render json: weather_for_antipode_city
  # binding.pry
  end
end
