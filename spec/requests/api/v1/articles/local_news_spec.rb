RSpec.describe "GET /v1/articles?longitude&latitude", type: :request do
  let!(:swedish_articles) { 5.times { create(:article, location: 'Sweden') } }
  let!(:danish_articles) { 5.times { create(:article, location: 'Denmark') } }

  describe 'successfully' do
    before do
      get "/api/v1/articles",
      params: {
        longitude: 18,
        latitude: 60
      }
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return articles' do
      expect(response_json["articles"].count).to eq 5
    end

    it 'should return the correct location on articles ' do
      expect(response_json["articles"].first["location"]).to eq "Sweden"
    end
  end
end
