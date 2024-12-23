class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :current_user, :token_expiration_date

  def initialize(options = {})
    @email = options[:email] || ''
    @password = options[:password] || ''
    @current_user = nil
    @token_expiration_date = 15.days.from_now
  end

  def call
    JsonWebToken.encode(user_id: user.id, expiration_date: token_expiration_date) if user
  end

  private

  attr_accessor :email, :password

  def user
    @user ||= begin
      user = User.lock.find_by_email(email)
      if user&.valid_password?(password)
        user.update!({
          sign_in_count: user.sign_in_count + 1,
          current_sign_in_at: DateTime.now
        })
        @current_user = user
      else
        errors.add :user_authentication, 'invalid credentials'
        nil
      end
    end
  end
end
