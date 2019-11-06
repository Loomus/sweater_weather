class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  # attributes :id

  attribute :city_weather do |object|
    object.city_weather
  end
end
