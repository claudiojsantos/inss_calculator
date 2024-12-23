class User < ApplicationRecord
  has_secure_password

  attr_accessor :auth_token, :token_expiration_date

  validates :name, presence: { message: 'Por favor, informe nome de usuário' }
  validates :email, presence: { message: 'Por favor, insira um endereço de e-mail válido.' }
  validates :email, uniqueness: { message: 'Este e-mail já está em uso.' }
  validates :password, presence: { message: 'Por favor, digite a senha.' }, if: :password_required?

  def valid_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def password_required?
    new_record? || password.present?
  end
end
