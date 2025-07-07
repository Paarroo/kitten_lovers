require "rails_helper"

RSpec.describe Admin::ManagementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/managements").to route_to("admin/managements#index")
    end

    it "routes to #new" do
      expect(get: "/admin/managements/new").to route_to("admin/managements#new")
    end

    it "routes to #show" do
      expect(get: "/admin/managements/1").to route_to("admin/managements#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/managements/1/edit").to route_to("admin/managements#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/managements").to route_to("admin/managements#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/managements/1").to route_to("admin/managements#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/managements/1").to route_to("admin/managements#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/managements/1").to route_to("admin/managements#destroy", id: "1")
    end
  end
end
