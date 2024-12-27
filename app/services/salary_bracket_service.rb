class SalaryBracketService
  def self.group_applicants_by_bracket(params)
    brackets = InssBracket.all
    result = {}

    brackets.each do |bracket|
      applicants = Applicant.where(salary: bracket.min_salary..bracket.max_salary)
      
      result[bracket] = applicants
    end

    last_bracket = InssBracket.last
    if last_bracket
      extra_applicants = Applicant.where('salary > ?', last_bracket.max_salary)
      result["Acima de #{last_bracket.max_salary}"] = extra_applicants
    end
    result
  end
end
