class Admin::BirthPlansController < Admin::ApplicationController

  #before_action :get_plan, only: [:update, :destroy]

  def new
    @birth_plan = BirthPlan.new
  end

  def create
    @birth_plan = BirthPlan.new(birth_plan_params)
    if @birth_plan.save
      flash[:success] = 'Birth Plan created successfully.'
      redirect_to admin_birth_plans_path
    else
      render :new
    end
  end

  def edit
    @birth_plan = BirthPlan.find(params[:id])
    @questions = Question.ordered
  end

  def update
    if @birth_plan.update(birth_plan_params)
      flash[:success] = 'Birth Plan updated.'
      redirect_to admin_birth_plans_path
    else
      render :edit
    end
  end

  def sort
    params[:sort].each do |k, v|
      question = Question.find(k)
      if question.present?
        question.update_attributes(order: v)
      end  
    end
    @questions = Question.ordered
    redirect_to admin_birth_plans_path
  end  

  def index
    @birth_plan = BirthPlan.first
    @questions = Question.ordered
    @question = Question.new
  end

  def get_question
    @restricted_questions = []
    @current_question = Question.find(params[:id])
    @restricted = RestrictQuestion.where("base_ques_id = ?", @current_question.id)
    @questions = Question.all
     @questions.each do |ques|
      if ques.order < @current_question.order
        @restricted_questions << ques
      end  
    end  
    #@restricted_questions = Question.where('order <  "#{question.order}"')
    respond_to do | format |  
      format.js {render :layout => false}  
    end
  end

  def restrict
    @restrict_questions = RestrictQuestion.where("base_ques_id = ?", params[:current_question_id])
    @restrict_questions.delete_all

    if params[:base_question].present?
      params[:question].each do |id, value|
        RestrictQuestion.create(main_ques_id: params[:question_id],
                                main_option_id: value,
                                base_ques_id: params[:base_question],
                                ques_status: false)     
      end  
    end
    if params[:base_option].present?
      params[:question].each do |id, value|
        params[:base_option].each do |opt, attribute|
          RestrictQuestion.create(main_ques_id: params[:question_id],
                                  main_option_id: value,
                                  base_ques_id: params[:current_question_id],
                                  base_option_id: opt,
                                  ques_status: true,
                                  option_status: false)     
        end  
      end 
    end  

    flash[:success] = 'Restriction Done'
    redirect_to admin_birth_plans_path
  end 
  
  private

  def birth_plan_params
    params.require(:birth_plan).permit(:title, :status, :description, question_attributes: [:id])
  end

end

