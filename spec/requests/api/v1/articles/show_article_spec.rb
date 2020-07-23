RSpec.describe "GET /v1/articles", type: :request do
  describe 'successfully gets articles' do
    let!(:article_1) { create(:article, title: 'The first article', lead: 'This is the first article lead', content: 'This is the first article content') }

    before do
      get 'api/v1/articles/#{article.id}'
    end

    it 'responds with 200 status' do
      expect(response.statue).to have_http_status 200
    end

    it 'shows article content' do
      expect(response_json['article'].first['content']).to eq 'This is the first article content'
    end
  end
end