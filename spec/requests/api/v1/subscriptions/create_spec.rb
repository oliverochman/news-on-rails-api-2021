RSpec.describe "POST /v1/subscriptions", type: :request do
  let(:user) { create(:user, role: 'registered')}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPTS: "application/json" }.merge!(credentials) }

  describe 'successfully with valid params and headers' do
    before do
      post '/api/v1/subscriptions',
      params: {
        stripeToken: 123456789
      },
      headers: headers
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json["message"]).to eq "Transaction was successfull"
    end

    it 'is expected to change user role to subscriber' do
      expect(user.role).to eq 'subscriber'
    end
  end
end
