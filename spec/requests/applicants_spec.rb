require 'rails_helper'

RSpec.describe "Applicants", type: :request do
  let(:user) { create(:user, password: '12345678') }
  let!(:applicant) { create(:applicant) }

  before do
    post '/login', params: { email: user.email, password: '12345678' }
    follow_redirect!
  end

  describe "GET /index" do
    context 'when user is logged in' do
      it 'returns http success as list five applicants' do
        get "/applicants"
        expect(response).to have_http_status(:success)
        expect(response.body).to render_template(:index)
        expect(response.body).to include("Proponentes")
      end
    end
  end

  describe "GET /applicants/new" do
    it 'render form to create a new applicant' do
      get "/applicants"
      follow_redirect! if response.redirect?

      get new_applicant_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Cadastro de Proponente")
      expect(assigns(:applicant).addresses.size).to eq(1)
      expect(assigns(:applicant).contacts.size).to eq(1)
    end
  end

  describe "POST /applicants" do
    context 'when params are valid' do
      let(:valid_params) do
        applicant = build(:applicant)
        {
          applicant: applicant.attributes.merge(
            addresses_attributes: [ attributes_for(:address) ],
            contacts_attributes: [ attributes_for(:contact) ]
          )
        }
      end

      it 'creates a new applicant' do
        expect {
          post '/applicants', params: valid_params
      }.to change(Applicant, :count).by(1)
        .and change(Address, :count).by(1)
        .and change(Contact, :count).by(1)
      end
    end
  end
end
