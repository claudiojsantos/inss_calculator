module Api
  module V1
    class ApplicantsController < ApiController
      before_action :set_applicant, only: %i[show]

      def index
        @applicants = Applicant.includes(:addresses, :contacts).page(params[:page])
        render json: @applicants, each_serializer: ApplicantSerializer
      end

      def show
        render json: @applicant, each_serializer: ApplicantSerializer
      end

      private

      def set_applicant
        @applicant = Applicant.find(params[:id])
      end
    end
  end
end
