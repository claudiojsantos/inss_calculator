class HomeController < ApplicationController
  def index
    @salary_bracket = SalaryBracketService.group_applicants_by_bracket(params)

    respond_to do |format|
      format.html 
      format.js   
    end
  end
end
