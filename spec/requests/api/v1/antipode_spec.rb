require 'rails_helper'

describe "Antipode API" do
  it "gets the antipode of a submitted location" do
     get '/api/v1/antipode?location=hongkong'
     # binding.pry
     expect(response).to be_successful
     antipode = JSON.parse(response.body)[:data]


  end
end
