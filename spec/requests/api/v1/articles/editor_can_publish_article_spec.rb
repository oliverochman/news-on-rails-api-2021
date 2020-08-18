RSpec.describe "PUT /articles", type: :request do
  let!(:editor) { create(:user, role: "editor")}
  let(:editor_credentials) { editor.create_new_auth_token }
  let(:editor_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editor_credentials) }

  let!(:article) { create(:article, category: 'sports', published: false ) }



  before do
    get '/api/v1/articles'
  end

  before { put "/api/v1/articles/#{article.id}", 
  params: { article: { published: true } },
   headers: editor_headers }

    it "should return a 200 status" do
      expect(response).to have_http_status 200
    end

    it "article should be published" do
      expect(Article.last["published"]).to eq true
    end
end