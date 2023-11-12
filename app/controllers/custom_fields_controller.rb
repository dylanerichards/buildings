class CustomFieldsController < ApplicationController
  def update
    custom_field = CustomField.find_by(
      building_id: params[:building_id], 
      field_name: params[:field_name],
    )

    custom_field.assign_attributes(
      field_name: params[:field_name],
      field_type: params[:field_type],
      enum_options: params[:enum_options],
      value: params[:value]
    )

    custom_field.save!

    render json: custom_field
  end
end
