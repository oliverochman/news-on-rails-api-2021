RSpec.describe "GET '/api/v1/admin/articles" do
  let!(:editor) { create(:user, role: "editor")}
  let(:editor_credentials) { editor.create_new_auth_token }
  let(:editor_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editor_credentials) }
  
  let!(:journalist) { create(:user, role: "journalist")}
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }
  
  let!(:article_1) { create(:article, title: 'The first article', journalist_id: journalist.id) }
  let!(:article_2) { create(:article, title: 'The second article', published: false) }
  let!(:article_3) { create(:article, title: 'The third article', content: 'This is the third article content', published: false, journalist_id: journalist.id) }
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

  describe 'journalist successfully gets his/her articles' do
    before do
      get '/api/v1/admin/articles',
      headers: journalist_headers 
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return his/her articles' do
      expect(response_json["articles"].count).to eq 2
    end

    it 'should return his/her article with title' do
      expect(response_json["articles"].first["title"]).to eq 'The first article'
    end

    it 'should return his/her article with content' do
      expect(response_json["articles"].second["content"]).to eq 'This is the third article content'
    end
  end

  describe "non-registered user unsuccessfully gets the articles " do
    before do 
      get '/api/v1/admin/articles'
    end 

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end

    it 'is expected to return error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end 

  describe "registered user which is not journalist/editor unsuccessfully gets the articles " do
    let(:unauthorized_user) { create(:user, role: 'registered') }
    let(:unauthorized_user_credentials) { unauthorized_user.create_new_auth_token }
    let(:unauthorized_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(unauthorized_user_credentials) }

    before do 
      get '/api/v1/admin/articles',
      headers: unauthorized_headers
    end 

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end 

    it 'is expected to return error message' do
      expect(response_json['message']).to eq 'You are not authorized to access this action'
    end
  end
end