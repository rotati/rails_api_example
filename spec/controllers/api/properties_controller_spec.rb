require 'rails_helper'

describe API::PropertiesController, :type => :controller do
  include JSONHelpers

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

    describe "specifying media type in headers" do
      context "returning properties as JSON" do
        before do
          @request.env["HTTP_ACCEPT"] = "application/json"
          get :index
        end

        it "should return the correct content type" do
          expect(response).to have_http_status(:success)
          expect(response.header['Content-Type']).to include 'application/json'
        end
      end

      context "returning properties as XML" do
        before do
          @request.env["HTTP_ACCEPT"] = "application/xml"
          get :index
        end

        it "should return the correct content type" do
          expect(response).to have_http_status(:success)
          expect(response.header['Content-Type']).to include 'application/xml'
        end
      end
    end
  end

  describe "SHOW :id" do
    let(:property) { create(:property) }

    before do
      property
    end

    it "should return the property with the specified id" do
      get :show, id: property.id
      fetched_property = json(response.body)
      expect(fetched_property[:name]).to eq property.name
    end
  end

end
