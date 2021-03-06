RSpec.describe'GET /api/v1/articles/', type: :request do
  let!(:journalist){create(:user, role: 'journalist')}
  let!(:article) { create(:article, category: 'sports', journalist_id: journalist.id) }
  let!(:article1) { create(:article, category: 'sports', journalist_id: journalist.id) }
  let!(:article2) { create(:article, category: 'economy', journalist_id: journalist.id) }

  describe'successfully'do
    before do
      get "/api/v1/articles",
      params:{category: "sports"}
    end

      it 'responds with a 200 status'do
        expect(response).to have_http_status 200
      end

      it 'should return articles with category sports' do
        expect(response_json["articles"].count).to eq 2
      end
  end

  describe'unsuccessfully' do
    before do
      get "/api/v1/articles",
      params:{category: "latest news"}
    end

    it 'responds with a 422 status' do
      expect(response).to have_http_status 422 
    end

    it 'responds with error message' do
      expect(response_json["message"]).to eq "Unfortunatly this category doesn't exist."
    end
  end
end
