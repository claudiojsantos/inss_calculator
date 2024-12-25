class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Success' }, status: :ok }
    end
  end
end
