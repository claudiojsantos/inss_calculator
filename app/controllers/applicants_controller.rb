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

  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      flash[:notice] = 'Proponent criado com sucesso.'
      redirect_to new_applicant_path
    else
      flah.now[:alert] = 'Não foi possível criar o proponente.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_applicant
    @aaplicant = Applicant.find(params[:id])
  end

  def applicant_params
    params.require(:applicant).permit(
      :name, :document, :birth_date, :salary, :inss_discount,
      addresses_attributes: [ :id, :address, :number, :neighborhood, :city, :state, :zip_code, :_destroy ],
      contacts_attributes: [ :id, :contact_type, :value, :_destroy ]
    )
  end
end
