class AuthenticationController < ApiController
  skip_before_action :authenticate_request

  def authenticate
    options = {
      email: params[:email]&.strip&.downcase,
      password: params[:password]
    }
    command = AuthenticateUser.call(options)

    if command.success?
      user = command.current_user
      user.auth_token = command.result
      user.token_expiration_date = command.token_expiration_date

      render json: user, each_serializer: UserSerializer
    else
      render json: { error: command.errors }, each_serializer: ErrorSerializer, status: :unauthorized
    end
  end
end
