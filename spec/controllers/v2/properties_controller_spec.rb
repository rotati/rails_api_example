require 'rails_helper'

RSpec.describe V2::PropertiesController, :type => :controller do
  include JSONHelpers

  describe "V2 properties/ping", :focus do
    it "should return 'From V2 PropertiesController'" do
      get :ping
      json = json(response.body)
      expect(json[:pong]).to include "From V2 PropertiesController"
    end
  end
end
