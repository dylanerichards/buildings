class BuildingSerializer < ActiveModel::Serializer
  attributes :id, :address, :city, :zip, :client

  def client
    object.client.name
  end
end
