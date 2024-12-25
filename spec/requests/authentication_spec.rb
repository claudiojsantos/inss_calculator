require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      email: user.email,
      password: "12345678"
    }
  end

  let(:invalid_params) do
    {
      email: user.email,
      password: "blablabla"
    }
  end

  describe "POST /authenticate" do
    let(:url) { '/authenticate' }

    context "when the credentials are valid" do
      it "returns the user data and auth token" do
        post url, params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(parsed_response['authToken']).to be_present
        expect(parsed_response['email']).to eq(user.email)
        expect(parsed_response['tokenExpirationDate']).to be_present
      end
    end

    context "when the credentials are invalid" do
      it "returns an unauthorized status with error message" do
        post url, params: invalid_params.to_json, headers: { 'Content-Type' => 'application/json' }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_response['error']).to be_present
      end
    end

    context "when email is missing" do
      it "returns an error for missing email" do
        post url, params: { password: "12345678" }.to_json, headers: { 'Content-Type' => 'application/json' }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_response['error']['user_authentication']).to eq("invalid credentials")
      end
    end

    context "when password is missing" do
      it "returns an error for missing password" do
        post url, params: { email: user.email }.to_json, headers: { 'Content-Type' => 'application/json' }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_response['error']['user_authentication']).to eq("invalid credentials")      end
    end
  end
end
