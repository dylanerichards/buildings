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
          client_id: client.id
        }
      }

      expect(Building.count).to eq 1
      expect(Building.first.address).to eq "1085 Broadway"
      expect(Building.first.client).to eq client
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
    end
  end
end
