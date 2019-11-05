class Antipode
  attr_reader :current_antipode_weather

  def initialize(data, location, city)
    @current_antipode_weather = create_antipode_data(data, location, city)
  end

  def create_antipode_data(data, location, city)
    summary = data[:currently][:summary]
    temperature = data[:currently][:temperature].round
    {
      search_location: location,
      location_name: city,
      summary: summary,
      current_temperature: temperature
    }
  end
end
