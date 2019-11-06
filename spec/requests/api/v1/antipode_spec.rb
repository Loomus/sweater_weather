require 'rails_helper'

describe "Antipode API" do
  it "gets the antipode of a submitted location" do
     get '/api/v1/antipode?location=hongkong'
     expect(response).to be_successful
     antipode = JSON.parse(response.body, symbolize_names: true)

     expect(antipode[:data][:attributes][:current_antipode_weather][:search_location]).to eq("hongkong")
     expect(antipode[:data][:attributes][:current_antipode_weather][:location_name]).to eq("America/La_Paz")

     # These two will change but were correct at the initial time of testing
     # A webmock would be useful to solidify the results of this api call
     # expect(antipode[:data][:attributes][:current_antipode_weather][:summary]).to eq("Mostly Cloudy")
     # expect(antipode[:data][:attributes][:current_antipode_weather][:current_temperature]).to eq(71)
  end
end
