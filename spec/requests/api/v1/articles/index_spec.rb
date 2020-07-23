require 'rails_helper'

RSpec.describe "GET /v1/articles", type: :request do
  describe'successfully gets articles' do
    let!(:articles) { 3.times{ create(:article)} }
    before do
      get'/api/v1/articles'
    end

    it'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it'should return article' do
      expect(response_json["articles"].count).to eq 3
    end
  end

  describe'no articles has been added' do
    before do
      get'/api/v1/articles'
    end
    
    it'should have no articles on page' do
      expect(response_json["articles"]).to eq []
    end
  end
end