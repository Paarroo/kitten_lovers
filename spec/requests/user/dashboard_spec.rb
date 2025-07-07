require 'rails_helper'

RSpec.describe "User::Dashboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/user/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end
