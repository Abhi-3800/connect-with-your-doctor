class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :destroy, :edit, :update]
  allow_unauthenticated_access only: [:index, :show]

  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to @hospital, notice: "Hospital was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @hospitals = Hospital.all.sort_by{ |hospital| hospital.id}
  end

  def show
    if @hospital
      render :show
    else
      render :new, { error: "Hospital not found" }, status: :not_found
    end
  end

  def edit
    @hospital = Hospital.find_by(id: params[:id])
  end

  def update
    if @hospital.update(hospital_params)
      @hospital.hospital_updates.create!(updated_by: Current.user.email_address, reason: params[:reason])
      redirect_to hospital_path(@hospital), notice: "Hospital was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @hospital
      @hospital.destroy
      redirect_to hospitals_path, notice: "Hospital deleted successfully"
    else
      render :new, { error: "Hospital not found" }, status: :not_found
    end
  end

  private

  def set_hospital
    @hospital = Hospital.find_by(id: params[:id])
  end

  def hospital_params
    params.require(:hospital).permit(:name, :address_line1, :address_line2, :city, :state, :zipcode, :country, :phone_number, :date_of_establishment, :reason)
  end
end