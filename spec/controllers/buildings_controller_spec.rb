require "rails_helper"

RSpec.describe BuildingsController, type: :controller do
  describe "#create" do
    let(:client) do
      Client.create(
        name: "dylan",
        email: "dylan@dylan.com",
        password: "password", 
        password_confirmation: "password"
      ) 
    end

    it "creates a building" do
      post :create, params: {
        building: {
          address: "1085 Broadway",
          city: "Brooklyn",
          zip: "11221",
          client_id: client.id,
        },
        custom_fields: [
          { field_name: "bathrooms", value: "1.5", field_type: "number"},
          { field_name: "pets", value: "yes", field_type: "freeform"}
        ]
      }

      expect(Building.count).to eq 1
      expect(Building.first.address).to eq "1085 Broadway"
      expect(Building.first.client).to eq client

      expect(JSON.parse(response.body).symbolize_keys).to eq({
          id: Building.first.id,
          address: "1085 Broadway",
          city: "Brooklyn",
          zip: "11221",
          client: client.name,
          custom_fields: [{ "bathrooms" => "1.5"}, {"pets" => "yes"}]
      })
    end
  end

  describe "#update" do
    let(:client) do
       Client.create(
        name: "dylan",
        email: "dylan@dylan.com",
        password: "password", 
        password_confirmation: "password"
      ) 
    end

    let(:building) do
      Building.create(
        address: "1085 Broadway",
        city: "Brooklyn",
        zip: "11221",
        client_id: client.id
      ) 
    end

    it "updates an existing building" do
      patch :update, params: {
        id: building.id,
        building: {
          address: "0 Bond",
          city: "New York",
          zip: "10003",
        }
      }

      expect(Building.first.city).to eq "New York"
      expect(Building.first.client).to eq client

      expect(JSON.parse(response.body).symbolize_keys).to eq({
          id: Building.first.id,
          address: "0 Bond",
          city: "New York",
          zip: "10003",
          client: client.name,
          custom_fields: []
      })
    end
  end

  describe "#index" do
    before do
      Building.create(
        address: "1085 Broadway",
        city: "Brooklyn",
        zip: "11221",
        client_id: client.id
      ) 

      Building.create(
        address: "1090 Broadway",
        city: "Brooklyn",
        zip: "11221",
        client_id: client.id
      ) 

      Building.create(
        address: "1100 Broadway",
        city: "Brooklyn",
        zip: "11221",
        client_id: client.id
      ) 
    end

    let(:client) do
      Client.create(
        name: "dylan",
        email: "dylan@dylan.com",
        password: "password", 
        password_confirmation: "password"
      ) 
    end

    it "returns all the buildings" do
      get :index

      expect(response.body).to eq(
        ActiveModel::SerializableResource.new(
        Building.all,
        each_serializer: BuildingSerializer
).to_json
      )
    end
  end
end
