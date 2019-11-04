require "rails_helper"

describe 'Backgrounds API' do
  it "gets an image" do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    image = JSON.parse(response.body)

    expect(image["data"].count).to eq(3)
    expect(image["data"]["attributes"]["image"]["url"]).to eq("https://farm1.staticflickr.com/930/43691964192_4ff507454d.jpg")
  end
end
