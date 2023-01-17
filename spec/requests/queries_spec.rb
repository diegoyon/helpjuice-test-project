require 'rails_helper'

RSpec.describe "Queries", type: :request do

  before :each do
    @user = User.create(email: 'test@gmail.com', password: 123456)
    sign_in @user
  end

  describe "GET /index" do
    it "returns http success" do
      get "/queries/index"
      expect(response).to have_http_status(:success)
    end
  end

end
