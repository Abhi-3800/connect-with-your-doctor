require "csv"

class NearbyHospitalsController < ApplicationController
  def index
  end

  def search
    @nearby_hospitals = []
    if params[:location].present?
      @nearby_hospitals = GetNearbyHospitalsService.new(params[:location]).call
      if @nearby_hospitals&.any?
        render :search
      else
        redirect_to nearby_hospitals_path, alert: "No hospitals found near the specified location."
      end
    else
      redirect_to nearby_hospitals_path, alert: "Please enter a location to search for nearby hospitals."
    end
  end

  def download_csv
    nearby_hospitals = []
    if params[:location].blank?
      redirect_to nearby_hospitals_path, alert: "Please enter a location to search for nearby hospitals."
      return
    end
    nearby_hospitals = GetNearbyHospitalsService.new(params[:location]).call
    if nearby_hospitals.empty?
      redirect_to nearby_hospitals_path, alert: "No hospitals found near the specified location."
      return
    end
    send_data generate_csv(nearby_hospitals), filename: "nearby_hospitals.csv", type: "text/csv"
  end

  private

  def generate_csv(hospitals)
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Name", "Address", "Latitude", "Longitude", "District", "Postal Code"]
      hospitals.each do |hospital|
        csv << [hospital.dig("tags","name"), hospital.dig("tags", "addr:full"), hospital["lat"], hospital["lon"], hospital.dig("tags", "addr:district"), hospital.dig("tags", "addr:postcode")]
      end
    end
    csv_data
  end

end
