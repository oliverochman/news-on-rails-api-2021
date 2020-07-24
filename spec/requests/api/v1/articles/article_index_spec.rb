RSpec.describe "GET /v1/articles", type: :request do
  describe 'successfully gets articles' do
    let!(:article_1) { create(:article, title: 'The first article', lead: 'This is the first article lead', category: 'Economy') }
    let!(:article_2) { create(:article, title: 'The second article', lead: 'This is the second article lead', category: 'Sports') }
    let!(:article_3) { create(:article, title: 'The third article', lead: 'This is the third article lead', category: 'Lifestyle') }

    before do
      get '/api/v1/articles'
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return article' do
      expect(response_json["articles"].count).to eq 3
    end

    it 'should return first article title' do
      expect(response_json["articles"].first["title"]).to eq "The first article"
    end

    it 'should return third article lead' do
      expect(response_json["articles"].last["lead"]).to eq "This is the third article lead"
    end

    it 'articles should have categories' do
      expect(response_jsons["articles"].first["category"]).to eq "Economy"
      expect(response_jsons["articles"].second["category"]).to eq "Sports"
      expect(response_jsons["articles"].last["category"]).to eq "Lifestyle"
    end
  end

  describe 'no articles has been added' do
    before do
      get '/api/v1/articles'
    end

    it 'should have no articles on page' do
      expect(response_json["articles"]).to eq []
    end
  end
end