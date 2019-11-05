class GoogleLocationService
  def self.google_data(location = nil, latlng = nil)
    if location
      response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
        f.params[:address] = location
        f.params[:key] = ENV['GOOGLE_API_KEY']
      end
    elsif latlng
      response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
        f.params[:latlng] = latlng
        f.params[:key] = ENV['GOOGLE_API_KEY']
      end
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
