class Admin::QuestionsController < Admin::ApplicationController

  before_action :get_question, only: [ :edit, :update, :destroy ]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = 'Question created successfully.'
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question updated.'
      redirect_to admin_questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question destroyed.'
    redirect_to admin_questions_path
  end

  def index
    @questions = Question.order('title asc')
  end


  private

  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :ques_type, :required, :note, options_attributes: [:id, :option_title, :question_id, :_destroy])
  end

end

