class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [ :show ]

  def index
    @applicants = Applicant.all.page(params[:page])

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
  end

  def new
    @applicant = Applicant.new
    @applicant.addresses.build
    @applicant.contacts.build
  end

  private

  def set_applicant
    @aaplicant = Applicant.find(params[:id])
  end
end
