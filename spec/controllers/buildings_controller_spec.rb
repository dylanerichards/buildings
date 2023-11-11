require "rails_helper"

RSpec.describe BuildingsController, type: :controller do
  describe "#create" do
    let(:client) do
      c = Client.create(
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

      expect(Building.count).to eq(1)
      expect(Building.first.address).to eq "1085 Broadway"
    end

  end
end
