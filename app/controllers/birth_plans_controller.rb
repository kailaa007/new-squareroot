class BirthPlansController < ApplicationController
  layout "devise"

  def index
    
  end

  def active_plan
    birth_plan_record = BirthPlanAnswer.find_by_user_id(current_user.id)
    @birth_plan = BirthPlan.first
    if birth_plan_record.present?
      redirect_to birth_plan_answer_path(@birth_plan)
    else
      @birth_plan_answer = BirthPlanAnswer.new
    end  
  end
 #{"ques"=>"29", "option"=>"38"}



  private

   def birth_plan_params
     params.require(:birth_plan).permit(:title, :status, :description, birth_plan_answer_attributes: [:id, :question, :answer, :ques_type, :user_id])
   end

end