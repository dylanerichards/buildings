# frozen_string_literal: true

class BuildingSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :zip, :client, :custom_fields

  def client
    object.client.name
  end

  def custom_fields
    CustomField.where(building_id: object.id)
               .map { |field| { field.field_name => field.value } }
  end
end
