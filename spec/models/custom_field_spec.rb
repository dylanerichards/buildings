require "rails_helper"

RSpec.describe CustomField do
  context "validations" do
    let(:client) do
      Client.create(
        name: "dylan",
        email: "dylan@dylan.com",
        password: "password", 
        password_confirmation: "password"
      ) 
    end

    let(:building) { Building.create(
      address: "1085 Broadway",
      city: "Brooklyn",
      zip: "11221",
      client_id: client.id,
    )}

    describe "proper values for field types" do
      context "when field type is freeform" do
        it "allows any kind of value" do
          expect {
            CustomField.create(
              field_name: "broker comment",
              value: "You don't want to miss this!",
              field_type: "freeform",
              building_id: building.id
            )
        }.to change(CustomField, :count).by 1
        end
      end



    end
  end
end