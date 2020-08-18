RSpec.describe "GET '/api/v1/admin/articles" do
  let!(:editor) { create(:user, role: "editor")}
  let(:editor_credentials) { editor.create_new_auth_token }
  let(:editor_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editor_credentials) }
  
  let!(:journalist) { create(:user, role: "journalist")}
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }
  
  let!(:article_1) { create(:article, title: 'The first article', journalist_id: journalist.id) }
  let!(:article_2) { create(:article, title: 'The second article', published: false, journalist_id: journalist.id) }
  let!(:article_3) { create(:article, title: 'The third article', content: 'This is the third article content', published: false) }
  let!(:article_4) { create(:article, title: 'The fourth article', published: false) }
  
  
  describe 'editor successfully gets unpublished articles' do
    before do
      get '/api/v1/admin/articles',
      headers: editor_headers 
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return unpublished articles' do
      expect(response_json["articles"].count).to eq 3
    end

    it 'should return unpublished article with title' do
      expect(response_json["articles"].first["title"]).to eq 'The second article'
    end

    it 'should return unpublished article with content' do
      expect(response_json["articles"].second["content"]).to eq 'This is the third article content'
    end
  end
end