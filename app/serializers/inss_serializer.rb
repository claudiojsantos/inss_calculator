class InssSerializer < BaseSerializer
  attributes :dalary, :inss_discount, :applicant_id

  def salary
    object[:salary]
  end

  def inss_discount
    object[:inss_discount]
  end

  def applicant_id
    object[:applicant_id]
  end
end
