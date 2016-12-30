class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end 

  def delete
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path
  end  

  def birth_plan_report
    @user = User.find(params[:id])
    @answers = BirthPlanAnswer.where("user_id = ?", @user.id)
    
    @questions = []
    questions = @answers.pluck(:question_id).uniq 

    questions.each do |ques|
      begin
        @questions <<  Question.find(ques)
      rescue Exception => e
        logger.error e.message    
        next
      end
    end   
  end  

end