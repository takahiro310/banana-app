require 'rails_helper'

RSpec.describe TopController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before do
      Asfor.delete_all
      Asfor.create(question: 'AAA', answer: 'AAA', url_key: 'AAA', image: 'AAA')
    end
    it "returns render template :index" do
      get :show, params: {url_key: 'AAA'}
      expect(response).to render_template(:index)
    end
    it "returns http error 404" do
      get :show, params: {url_key: 'NODATA'}
      expect(response).to have_http_status 404
    end
  end

end
