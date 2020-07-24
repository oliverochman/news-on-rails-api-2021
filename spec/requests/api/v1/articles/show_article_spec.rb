RSpec.describe "GET /v1/articles", type: :request do
  let!(:article) { create(:article, title: 'The first article', lead: 'This is the first article lead', content: 'This is the first article content') }
  let!(:article2) { create(:article) }

  describe 'successfully gets articles' do
    before do
      get "/api/v1/articles/#{article.id}"
    end

    it 'responds with 200 status' do
      expect(response).to have_http_status 200
    end

    it 'shows article content' do
      expect(response_json['article']['content']).to eq 'This is the first article content'
    end
  end
end