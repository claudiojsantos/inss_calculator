class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [ :new, :create ]
  layout 'login', only: [ :new, :create ]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Login bem-sucedido!'
      redirect_to root_path
    else
      flash.now[:alert] = 'E-mail ou senha inválidos.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:notice] = 'Logout bem-sucedido!'
    redirect_to login_path
  end
end
