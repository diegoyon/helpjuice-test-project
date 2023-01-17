require 'rails_helper'

RSpec.describe "Queries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/queries/index"
      expect(response).to have_http_status(:success)
    end
  end

end
