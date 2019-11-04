class Antipode
  attr_accessor :current_antipode_weather, :id

  def initialize(data, location)
    @data = data
    @location = location
    @current_antipode_weather = {}
    @id = 1
  end

  def create_antipode_data
    summary = @data[:currently][:summary]
    temperature = @data[:currently][:temperature].round
    antipode_location = @data[:timezone]
    @current_antipode_weather = {
      search_location: @location,
      location_name: antipode_location,
      summary: summary,
      current_temperature: temperature
    }
  end
end
