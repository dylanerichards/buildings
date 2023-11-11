class BuildingsController < ApplicationController
  def create
    Building.create(building_params)
  end

  private

  def building_params
    params.require(:building).permit(:name, :address, :city, :zip, :client_id)
  end
end
