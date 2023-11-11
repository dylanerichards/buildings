class BuildingsController < ApplicationController
  def index
    render json: Building.all, each_serializer: BuildingSerializer
  end

  def create
    building = Building.new(building_params)

    if building.save
      render json: building
    else
      render json: {
        errors: building.errors.messages
      }
    end
  end

  def update
    building = Building.find(params[:id])

    building.update(building_params)

    render json: building
  end

  private

  def building_params
    params.require(:building).permit(:name, :address, :city, :zip, :client_id)
  end
end
