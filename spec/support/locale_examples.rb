shared_examples "a multi locale resource" do |options|
  options ||={}
  let(:params) { {} } #default empty params

  def it_should_return_the_resource_in_the_correct_language
    expect(fetched_property[:heading]).to eq expected_heading
  end

  describe "changing locales" do
    let(:fetched_property) do
      properties = json(response.body)
      properties.class == Array ? properties[0] : properties
    end

    before do
      @request.env['HTTP_ACCEPT_LANGUAGE'] = lang
      get options[:action], params
    end

    context "requesting property details in English" do
      let(:expected_heading) { "Wonderful property in #{fetched_property[:province]}" }
      let(:lang) { "en" }

      it "should return a list of properties in English" do
        it_should_return_the_resource_in_the_correct_language
      end
    end

    context "requesting property details in French" do
      let(:expected_heading) { "Magnifique propriété à #{fetched_property[:province]}" }
      let(:lang) { "fr" }

      it "should return a list of properties in French" do
        it_should_return_the_resource_in_the_correct_language
      end
    end
  end
end
