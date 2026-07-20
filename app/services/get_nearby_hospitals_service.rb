require "net/http"
require "json"

class GetNearbyHospitalsService
  def initialize(location)
    @location = location
  end

  def call
    coordinates = geocode_location
    return [] unless coordinates

    search_hospitals(coordinates[:lat], coordinates[:lon])
  end

  private

  def geocode_location
    uri = URI(ENV["NOMINATIM_URL"])

    params = {
      q: @location,
      format: "json",
      limit: 1
    }

    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "ConnectWithYourDoctor/1.0"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)

    return nil if result.empty?

    {
      lat: result.first["lat"],
      lon: result.first["lon"]
    }
  end

  def search_hospitals(lat, lon)

    query = <<~OVERPASS
      [out:json];
      (
        node["amenity"="hospital"](around:50000,#{lat},#{lon});
        way["amenity"="hospital"](around:50000,#{lat},#{lon});
        relation["amenity"="hospital"](around:50000,#{lat},#{lon});
      );
      out center tags;
    OVERPASS

    uri = URI(ENV["OVERPASS_URL"])

    request = Net::HTTP::Post.new(uri)
    request.set_form_data(data: query)
    response = Net::HTTP.start(uri.host, port: uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    puts "Status: #{response.code}"
    begin
      hospitals = JSON.parse(response.body)["elements"]
    rescue JSON::ParserError => e
      Rails.logger.error e.message
      Rails.logger.error response.body
      return
    end
    hospitals.select do |hospital|
      hospital.dig("tags","name").present? && hospital.dig("tags", "addr:full")
    end
  end
end