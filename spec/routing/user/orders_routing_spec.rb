require "rails_helper"

RSpec.describe User::OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user/orders").to route_to("user/orders#index")
    end

    it "routes to #new" do
      expect(get: "/user/orders/new").to route_to("user/orders#new")
    end

    it "routes to #show" do
      expect(get: "/user/orders/1").to route_to("user/orders#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user/orders/1/edit").to route_to("user/orders#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user/orders").to route_to("user/orders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user/orders/1").to route_to("user/orders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user/orders/1").to route_to("user/orders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user/orders/1").to route_to("user/orders#destroy", id: "1")
    end
  end
end
