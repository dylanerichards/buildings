# frozen_string_literal: true

class CustomFieldsController < ApplicationController
  def update
    custom_field = CustomField.find_by(
      building_id: params[:building_id],
      field_name: params[:field_name]
    )

    custom_field.update!(
      value: params[:value]
    )

    render json: custom_field
  end
end
