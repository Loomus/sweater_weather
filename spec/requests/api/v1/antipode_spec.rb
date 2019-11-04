require 'rails_helper'

describe "Antipode API" do
  it "gets the antipode of a submitted location" do
     get '/api/v1/antipode?location=hongkong'
     binding.pry
  end
end
