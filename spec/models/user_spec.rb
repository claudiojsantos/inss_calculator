require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email).with_message('Por favor, insira um endereço de e-mail válido.') }
    it { should validate_presence_of(:password).with_message('Por favor, digite a senha.') }
    it { should validate_confirmation_of(:password).with_message('As senhas não coincidem.') }
    it { should validate_uniqueness_of(:email).with_message('Este e-mail já está em uso.') }
    it { should validate_confirmation_of(:password).with_message('As senhas não coincidem.') }
  end
end
