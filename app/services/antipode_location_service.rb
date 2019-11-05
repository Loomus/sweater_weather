class AntipodeLocationService
  def self.find(location)
    lat = location[:results].first[:geometry][:location][:lat]
    lng = location[:results].first[:geometry][:location][:lng]
    response = Faraday.get("http://amypode.herokuapp.com/api/v1/antipodes?lat=#{lat}&long=#{lng}") do |f|
      f.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
