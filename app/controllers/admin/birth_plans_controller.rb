class Admin::BirthPlansController < Admin::ApplicationController

  before_action :get_plan, only: [ :edit, :update, :destroy]

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
  end

  def update
    if @birth_plan.update(birth_plan_params)
      flash[:success] = 'Birth Plan updated.'
      redirect_to admin_birth_plans_path
    else
      render :edit
    end
  end

  def destroy
    @birth_plan.destroy
    flash[:success] = 'Birth Plan destroyed.'
    redirect_to admin_birth_plans_path
  end

  def index
    @birth_plans = BirthPlan.order('title asc')
  end

  def assign_ques
    @questions = Question.all
    if params[:search].present?
      keyword = params[:search]
      @birth_plan = BirthPlan.find_by_title(params[:search])
    end  
    if request.patch?
      @birth_plan = BirthPlan.find(params[:birth_plan_id].to_i)
      @questions.each do |ques|
        
        if params["#{ques.id.to_s}"] == 'on'
          
          if @birth_plan.questions.any?
            @birth_plan.questions.delete_all
            @birth_plan_question = @birth_plan.birth_plan_questions.new(:question_id => ques.id, birth_plan_id: @birth_plan_id)
            @birth_plan_question.save!   
          else
            @birth_plan_question = BirthPlanQuestion.create!(:question_id => ques.id, birth_plan_id: @birth_plan.id)
            #@birth_plan_question.save!  
          end      
        end      
      end
      redirect_to :back, notice: "Question are assigned to Survey Template page successfully." 
    end
    
  end 


  private

  def get_plan
    @birth_plan = BirthPlan.find(params[:id])
  end

  def birth_plan_params
    params.require(:birth_plan).permit(:title, :status, :description)
  end

end

