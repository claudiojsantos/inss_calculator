class InssCalculatorJob < ActiveJob::Base
  queue_as :default

  def perform(salary, applicant_id)
    discount = InssCalculatorService.calculate(salary)
    applicant = Applicant.find(applicant_id)

    applicant.update(inss_discount: discount)

    Rails.logger.info("INSS calculado para o candidato ##{applicant.id}: Desconto de R$ #{discount}")
  end
end
