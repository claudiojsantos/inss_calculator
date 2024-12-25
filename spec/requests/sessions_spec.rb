require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user, { password: "12345678" }) }

  describe "GET /new" do
    it "render login page" do
      get login_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Seja Bem-Vindo")
    end
  end

  describe "POST /create" do
    context 'with valid credentials' do
      it 'log with user and set session variable' do
        post sessions_path, params: { email: user.email, password: "12345678" }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "with invalid credentials" do
      it "re-renders the login page with an error" do
        post sessions_path, params: { email: user.email, password: "wrongpassword" }
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
