require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { create(:user, password: '12345678') }

  before do
    post '/login', params: { email: user.email, password: '12345678' }
    follow_redirect!
  end

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
