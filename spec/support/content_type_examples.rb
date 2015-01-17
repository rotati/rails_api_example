shared_examples "a multi mimetype resource" do |options|
  options ||={}
  let(:params) { {} } #default empty params

  def it_should_return_the_correct_content_type
    expect(response).to have_http_status(:success)
    expect(response.header['Content-Type']).to include mimetype
  end

  describe "specifying HTTP_ACCEPT mimetype in request headers" do
    before do
      @request.env["HTTP_ACCEPT"] = mimetype
      get options[:action], params
    end

    context "returning properties as JSON" do
      let(:mimetype) { Mime::JSON }

      it "should return the resource as JSON" do
        it_should_return_the_correct_content_type
      end
    end

    context "returning properties as XML" do
      let(:mimetype) { Mime::XML }

      it "should return the resource as XML" do
        it_should_return_the_correct_content_type
      end
    end
  end
end
