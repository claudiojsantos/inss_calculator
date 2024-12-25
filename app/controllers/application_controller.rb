class ApplicationController < ActionController::Base
  before_action :authenticate_request

  helper_method :current_user, :user_signed_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_request
    if request.format.json?
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Acesso não autorizado' }, status: :unauthorized unless @current_user
    else
      unless user_signed_in?
        flash[:alert] = 'Acesso não permitido.'
        redirect_to login_path
      end
    end
  end

  def user_signed_in?
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    @current_user.present?
  end
end
