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
    it'should return title' do
      expect(response_json["articles"].first["title"]).to have_content "News on Rails is live"
    end
    it'should return lead' do
      expect(response_json["articles"].first["lead"]).to have_content "Yes it is correct"
    end
  end
end