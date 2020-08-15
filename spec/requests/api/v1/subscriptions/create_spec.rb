require 'stripe_mock'

RSpec.describe "POST /v1/subscriptions", type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper}
  before(:each) {StripeMock.start}
  after(:each)  {StripeMock.stop}
  let(:valid_token) { stripe_helper.generate_card_token}

  let(:product) { stripe_helper.create_product}
  let!(:plan) do
    stripe_helper.create_plan(
      id: "nor_subscription_plan",
      amount: 149,
      currency: "usd",
      interval: "month",
      interval_count: 12,
      name: "News On Rails Subscription",
      product: product.id

    )

  end

  let(:user) { create(:user, role: 'registered')}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPTS: "application/json" }.merge!(credentials) }

  describe 'successfully with valid params and headers' do
    before do
      post '/api/v1/subscriptions',
      params: {
        stripeToken: valid_token
      },
      headers: headers
    end

    it 'is expected  to return a 200 response status' do
      expect(response).to have_http_status 200 
    end

    it 'is expected to return a success message' do
      expect(response_json["message"]).to eq "Transaction was successfull"
    end

    it 'is expected to change user role to subscriber' do
      user.reload
      expect(user.role).to eq 'subscriber'
    end
  end
end