require 'rails_helper'

describe API::PropertiesController, :type => :controller do
  include JSONHelpers
  # call render_views method becuase we use jbuilder to build the JSON response
  render_views

  describe "GET index" do
    let(:property) { create(:property) }

    before do
      property
    end

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

    it_should_behave_like "a multi mimetype resource", action: :index
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

    it_should_behave_like "a multi locale resource", action: :show do
      let(:params) { {id: property.id} }
    end

    it_should_behave_like "a multi mimetype resource", action: :show do
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

      expect(api_property_url(created_property[:id])).to eq response.location
    end

    it "should not create a property with invalid parameters (i.e. nil name)" do
      expect{
        post :create, property: FactoryGirl.attributes_for(:property).merge(name: nil)
      }.not_to change(Property,:count)
    end
  end
end
