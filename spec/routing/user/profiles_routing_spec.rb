require "rails_helper"

RSpec.describe User::ProfilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user/profiles").to route_to("user/profiles#index")
    end

    it "routes to #new" do
      expect(get: "/user/profiles/new").to route_to("user/profiles#new")
    end

    it "routes to #show" do
      expect(get: "/user/profiles/1").to route_to("user/profiles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user/profiles/1/edit").to route_to("user/profiles#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user/profiles").to route_to("user/profiles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user/profiles/1").to route_to("user/profiles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user/profiles/1").to route_to("user/profiles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user/profiles/1").to route_to("user/profiles#destroy", id: "1")
    end
  end
end
