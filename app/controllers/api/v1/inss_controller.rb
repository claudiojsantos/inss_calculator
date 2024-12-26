module Api
  module V1
    class InssController < ApiController
      def calcule_inss
        salary = params[:salary].to_d
        applicant_id = params[:applicant_id]

        if salary <= 0
          render json: { error: 'Salário inválido' }, status: :unprocessable_entity
          return
        end

        InssCalculatorJob.perform_later(salary, applicant_id)

        render json: { message: 'Cálculo do INSS agendado com sucesso' }, status: :ok
      end
    end
  end
end
