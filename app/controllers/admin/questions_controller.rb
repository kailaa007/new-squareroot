class Admin::QuestionsController < Admin::ApplicationController

  before_action :get_question, only: [ :edit, :update, :destroy ]

  def new
    @question = Question.new
  end

  
  def create

    @question = Question.new(question_params)
    if @question.save
      if @question.ques_type == 1
        @question.options.create([
          { option_title: 'true' },
          { option_title: 'false' }
        ])
      end  
      flash[:success] = 'Question created successfully.'
      redirect_to admin_birth_plans_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.ques_type != params[:question][:ques_type].to_i
      unless RestrictQuestion.where("main_ques_id = ? OR base_ques_id = ?", @question.id, @question.id).empty?
        flash[:error] = "Please remove your restriction first."
        render :edit
      else
        if @question.ques_type != 1 && params[:question][:ques_type].to_i == 1
          @question.update(question_params)
          @question.options.create([
            { option_title: 'true' },
            { option_title: 'false' }
          ])
          flash[:success] = 'Question updated.'
          redirect_to admin_birth_plans_path
          return
        elsif @question.ques_type == 1 && params[:question][:ques_type].to_i != 1
          @question.update(question_params)
          @question.options.delete_all
          flash[:success] = 'Question updated.'
          redirect_to admin_birth_plans_path
          return
        elsif @question.update(question_params)
          flash[:success] = 'Question updated.'
          redirect_to admin_birth_plans_path
        else
          render :edit
        end
      end  
    else
      @question.update(question_params)
      flash[:success] = 'Question updated.'
      redirect_to admin_birth_plans_path
    end 
  end

  def destroy
    RestrictQuestion.where('base_ques_id = ?', @question.id).delete_all
    @question.destroy
    flash[:success] = 'Question destroyed.'
    redirect_to admin_birth_plans_path
  end

  def index
    @questions = Question.order('title asc').paginate(:page => params[:page])
  end


  private

  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :order,:ques_type, :required, :note, options_attributes: [:id, :option_title, :question_id, :_destroy])
  end

end

