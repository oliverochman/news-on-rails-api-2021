RSpec.describe'GET /api/v1/articles/', type: :request do
  let!(:article) { create(:article, category: 0) }
  let!(:article1) { create(:article, category: 0) }
  let!(:article2) { create(:article, category: 1) }

  describe'successfully'do
  before do
    get "/api/v1/articles",
    params:{category: "sports"}
  end
    it'responds with a 200 status'do
    expect(response).to have_http_status 200
    end

    it 'should return articles with category sports' do
      expect(response_json["articles"].count).to eq 2
    end
  end
end
