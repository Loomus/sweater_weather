require 'rails_helper'

RSpec.describe "Forecast API" do
  context 'main section' do

    it "returns main city info from given city" do
      get '/api/v1/forecast?location=denver,co'

      forecast_data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather]

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

  context 'details section' do
  it "returns details from given city" do
      get '/api/v1/forecast?location=denver,co'

      details = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather]

      expect(details).to have_key(:summary)
      expect(details).to have_key(:icon)
      expect(details).to have_key(:today)
      expect(details).to have_key(:tonight)
      expect(details).to have_key(:feels_like)
      expect(details).to have_key(:humidity)
      expect(details).to have_key(:visibility)
      expect(details).to have_key(:uv_index)
    end
  end

  context 'future forecast section' do
    it "returns future forecast from given city" do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      future_forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:city_weather]
      # binding.pry
      expect(future_forecast[:hourly].length).to eq(8)
      expect(future_forecast[:daily].length).to eq(5)
      expect(future_forecast[:hourly].first).to have_key(:time)
      expect(future_forecast[:hourly].first).to have_key(:temperature)
      expect(future_forecast[:daily].first).to have_key(:week_day)
      expect(future_forecast[:daily].first).to have_key(:summary)
      expect(future_forecast[:daily].first).to have_key(:icon)
      expect(future_forecast[:daily].first).to have_key(:humidity)
      expect(future_forecast[:daily].first).to have_key(:high)
      expect(future_forecast[:daily].first).to have_key(:low)
    end
  end
end
