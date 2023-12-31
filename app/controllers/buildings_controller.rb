# frozen_string_literal: true

class BuildingsController < ApplicationController
  def index
    @pagy, @records = pagy(Building.all)

    render json: @records, each_serializer: BuildingSerializer
  end

  def create
    building = Building.new(building_params)

    if building.save
      custom_field_params['custom_fields'].each do |param|
        building.custom_fields.create!(param)
      end

      render json: {
        message: 'success',
        building: ::BuildingSerializer.new(building)
      }

    else
      render json: {
        errors: building.errors.messages
      }
    end
  end

  def update
    building = Building.find(params[:id])

    building.update(building_params)

    render json: {
      message: 'success',
      building: ::BuildingSerializer.new(building)
    }
  end

  private

  def building_params
    params.require(:building).permit(:name, :address, :city, :zip, :client_id)
  end

  def custom_field_params
    params.permit(
      custom_fields: %i[field_name field_type value enum_options]
    )
  end
end
