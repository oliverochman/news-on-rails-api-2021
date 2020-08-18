RSpec.describe "PUT /admin/articles", type: :request do
  let!(:editor) { create(:user, role: "editor")}
  let(:editor_credentials) { editor.create_new_auth_token }
  let(:editor_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editor_credentials) }

  let!(:journalist) { create(:user, role: "journalist")}
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }

  let!(:article) { create(:article, published: false ) }
  let!(:article_2) { create(:article) }

  describe "successfully" do
    before do
      put "/api/v1/admin/articles/#{article.id}", 
      params: { 
        article: { published: true } 
      },
      headers: editor_headers 
    end

    it "should return a 200 status" do
      expect(response).to have_http_status 200
    end

    it "article should be published" do
      expect(Article.last["published"]).to eq true
    end

    it "should return success message" do
      expect(response_json['message']).to eq "The article was successfully published!"
    end
  end

  describe "unsuccessfully publish on already published article" do
    before do
      put "/api/v1/admin/articles/#{article_2.id}", 
      params: { 
        article: { published: true } 
      },
      headers: editor_headers 
    end

    it "should return a 422 status" do
      expect(response).to have_http_status 422
    end

    it 'is expected to return error message' do
      expect(response_json['message']).to eq "This article has already been published."
    end
  end

  describe "unsuccessfully as a journalist" do
    before do
      put "/api/v1/admin/articles/#{article.id}", 
      params: { 
        article: { published: true } 
      },
      headers: journalist_headers 
    end

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end

    it "article should not be published" do
      expect(Article.first["published"]).to eq false
    end

    it "should return error message" do
      expect(response_json['message']).to eq "You are not authorized to access this action"
    end
  end

  describe "unsuccessfully as unauthorized user" do
    before do
      put "/api/v1/admin/articles/#{article.id}", 
      params: { 
        article: { published: true } 
      }
    end

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end

    it "article should not be published" do
      expect(Article.first["published"]).to eq false
    end

    it "should return error message" do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end