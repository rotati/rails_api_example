require 'rails_helper'

describe "versioned api routes" do
  shared_examples "a versioned router" do |options|
    it "should route to the #{options[:version]} controller" do
      { :get => "http://api.example.com/#{options[:version]}/properties" }.should route_to(
        :format => :json,
        :subdomain=>"api",
        :controller => "#{options[:version]}/properties",
        :action => "index")
    end
  end

  it_behaves_like "a versioned router", version: 'v1'
  it_behaves_like "a versioned router", version: 'v2'
end
