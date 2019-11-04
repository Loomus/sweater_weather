require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'

      forecast_data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather][:main]

      expect(forecast_data).to have_key(:city)
      expect(forecast_data[:city]).to eq('denver, co')
      expect(forecast_data).to have_key(:summary)
      expect(forecast_data).to have_key(:temperature)
      expect(forecast_data).to have_key(:high)
      expect(forecast_data).to have_key(:low)
      expect(forecast_data).to have_key(:country)
      expect(forecast_data).to have_key(:time)
      expect(forecast_data).to have_key(:date)
      expect(forecast_data).to have_key(:icon)
    end

    it "returns 404 if invalid city" do
      expect{ get '/api/v1/forecast?location=invalid' }.to raise_error(ActionController::RoutingError)
    end
  end
end
