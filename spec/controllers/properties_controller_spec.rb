require 'rails_helper'

describe PropertiesController, :type => :controller do
  include JSONHelpers

  let(:property) { create(:property) }

  before do
    property
    @request.env['HTTP_ACCEPT'] = "application/vnd.rotati.v20150120+json"
  end

  describe "GET index" do
    it "returns a list of all the properties" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).not_to be_empty
    end

    context "filtering by province" do
      let(:property_kandal) { create(:property, name: 'Property in Kandal', province: 'kandal') }
      let(:property_battambang) { create(:property, name: 'Property in Battambang', province: 'battambang') }

      before do
        property_kandal
        property_battambang
      end

      it "returns only the properties by filtered province" do
        get :index, province: 'kandal'

        properties = json(response.body)
        names = properties.collect { |z| z[:name] }
        expect(names).to match_array(['Property in Kandal'])
      end
    end

    it_should_behave_like "a multi locale resource", action: :index
  end

  describe "SHOW :id" do
    it "should return the property with the specified id" do
      get :show, id: property.id
      fetched_property = json(response.body)
      expect(fetched_property[:name]).to eq property.name
    end

    it_should_behave_like "a multi locale resource", action: :show do
      let(:params) { {id: property.id} }
    end
  end

  describe "POST property" do
    it "should create a new property" do
      expect{
        post :create, property: FactoryGirl.attributes_for(:property)
      }.to change(Property,:count).by(1)

      expect(response).to have_http_status(:created)

      expect(response.header['Content-Type']).to include Mime::JSON

      created_property = json(response.body)

      expect(property_url(created_property[:id])).to eq response.location
    end

    it "should not create a property with invalid parameters (i.e. nil name)" do
      expect{
        post :create, property: FactoryGirl.attributes_for(:property).merge(name: nil)
      }.not_to change(Property,:count)
    end
  end

  describe "PATCH property" do
    def property_attribute(options={})
      FactoryGirl.attributes_for(:property).merge!(options)
    end

    context "passing valid attributes" do
      before do
        patch :update, id: property.id, property: property_attribute(name: "A new name")
      end

      it "should update an existing property" do
        property.reload.name.should eq "A new name"
      end
    end

    context "passing invalid attributes" do
      before do
        patch :update, id: property.id, property: property_attribute(name: nil)
      end

      it "should not update the property when passed invalid attributes" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE property" do
    it "should delete the property" do
      expect{
        delete :destroy, id: property.id
      }.to change(Property, :count).from(1).to(0)
    end
  end

  describe "Versioning" do
    shared_examples "a versionable api" do |options|
      options ||={}

      context "by url params" do
        describe "SHOW /property/:id" do
          it "should include the version number #{options[:version]}" do
            get :show, id: property.id, version: options[:version]
            property = json(response.body)
            expect(property[:version]).to eq options[:version]
          end
        end

        describe "GET /properties" do
          it "should include the version number #{options[:version]}" do
            get :index, version: options[:version]
            properties = json(response.body)
            expect(properties[0][:version]).to eq options[:version]
          end
        end
      end

      context "by accept header" do
        before do
          @request.env['HTTP_ACCEPT'] = "application/vnd.rotati.v#{options[:version]}+json"
        end

        it "should include the version number #{options[:version]}" do
          get :show, id: property.id
          property = json(response.body)
          expect(property[:version]).to eq options[:version]
        end
      end
    end

    it_should_behave_like "a versionable api", version: '20150120'

    it_should_behave_like "a versionable api", version: '20150116'
  end

  describe "Authentication" do
    context "without authentication credentials" do
      it "should not allow access to the exclusive area of the api" do
        get :exclusive
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with correct authentication credentials" do
      let(:encoded_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials('dadou', 'dadouland') }

      before do
        @request.env['HTTP_AUTHORIZATION'] = encoded_credentials
      end

      it "should allow access to the api" do
        get :exclusive
        expect(response).to have_http_status(:ok)
        expect(json(response.body)[:message]).to eq "Welcome exclusive member!"
      end
    end
  end
end
