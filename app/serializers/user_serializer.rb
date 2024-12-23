class UserSerializer < BaseSerializer
  attributes :id, :name, :email, :auth_token, :token_expiration_date
end
