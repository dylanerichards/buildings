require 'rails_helper'

RSpec.describe "CustomFields", type: :request do
  describe "GET /update" do
    it "returns http success" do
      get "/custom_fields/update"
      expect(response).to have_http_status(:success)
    end
  end

end
