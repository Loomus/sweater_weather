require 'rails_helper'

describe "Antipode API" do
  it "gets the antipode of a submitted location" do
     get '/api/v1/antipode?location=hongkong'
     expect(response).to be_successful
     antipode = JSON.parse(response.body)

     binding.pry
     # [:data][:attributes][:current_antipode_weather]
     expect(antipode[:search_location]).to eq("hongkong")
     # expect(antipode["data"].count).to eq(3)
     # expect(antipode["data"].count).to eq(3)


  end
end
