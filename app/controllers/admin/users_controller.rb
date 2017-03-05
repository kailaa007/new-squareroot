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
    @birth_plan_answers = @user.birth_plan_answers
  end  

  def edit_report
    @user = User.find(params[:id])
    @checklists         = Checklist.order(:category, :sub_category)
    @category           = @checklists.map(&:category).uniq.compact
    @checklist_answers  = @user.checklist_answers
    @self_checklists    = @user.checklist_answers.where(checklist_id: [nil, ''])
    @cat_id             = params[:c_id].present? ? params[:c_id].to_i : 1
    @birth_plan_checklist  = BirthPlan.first.try(:checklist_on) == Question::CATEGORY_TYPES[@cat_id-1]
    @questions          = Question.order(:order)
    @restricted_questions  = Question.where(id: @user.birth_plan_answers.map(&:question_id)).map(&:restrict_questions).flatten.compact.select{|x| x.ques_status == false}.map(&:base_ques_id)
    @restricted_options  = RestrictQuestion.where( main_option_id: @user.birth_plan_answers.map(&:answer_options).flatten.map(&:option_id), option_status: false).map(&:base_option_id)
    @birth_plan         = BirthPlanAnswer.new
  end
  
end