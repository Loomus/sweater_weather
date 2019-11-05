class Antipode
  attr_accessor :current_antipode_weather, :id

  def initialize(data, location, city)
    @data = data
    @location = location
    @current_antipode_weather = {}
    @id = 1
    @city = city
  end

  def create_antipode_data
    summary = @data[:currently][:summary]
    temperature = @data[:currently][:temperature].round
    @current_antipode_weather = {
      search_location: @location,
      location_name: @city,
      summary: summary,
      current_temperature: temperature
    }
  end
end
