#we want to create an article, only a journalist should be able to create an article
#Journalist has many articles and article belong to journalist

RSpec.describe "POST /v1/articles", type: :request do
  let(:journalist) { create(:user, role: 'journalist') }
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }

  describe 'successfully with vaild params and headers' do 
    before do 
      post '/api/v1/articles',
      params: {
        title: 'Scrum Lord',
        lead: 'All hail thy scrum lord',
        content: 'A good scrum lord will save us',
        category: 'lifestyle'  
      }, headers: journalist_headers 
    end
    
    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'Articles successfully created'
    end

    it 'is expected to create article' do
      article = Article.last
      expect(article.title).to eq 'Scrum Lord'
    end

    it 'article is expected to be associated with journalist' do
      expect(journalist.articles.first.lead).to eq 'All hail thy scrum lord'
    end
  end
end