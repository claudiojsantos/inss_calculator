require 'rails_helper'

RSpec.describe "Api::V1::Applicants", type: :request do
  let(:user) { create(:user) }
  let!(:applicants) { create_list(:applicant, 10) }
  let(:login) { "/authenticate" }
  let(:url) { "/api/v1/applicants" }

  let(:headers) do
    post login, params: { email: user.email, password: user.password }
    { 'Authorization': "Bearer #{JSON.parse(response.body)['authToken']}" }
  end

  describe "GET /api/v1/applicants" do
    it 'returns a list of applicants' do
      get url, params: { page: 1 }, headers: headers

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(5)
      expect(json_response.first['id']).to eq(applicants.first.id)
    end
  end
end
