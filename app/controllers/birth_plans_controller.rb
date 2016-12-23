class BirthPlansController < ApplicationController
  layout "devise"

  def active_plan
    @birth_plan = BirthPlan.first
  end

  def answer
  end 	

  private

   def birth_plan_params
     params.require(:birth_plan).permit(:title, :status, :description, birth_answers_attributes: [:id, :question, :answer, :ques_type, :user_id])
   end

end