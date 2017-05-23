class ChecklistAnswersController < ApplicationController
  before_action :set_checklist_answer, only: [:show, :edit, :update, :destroy]

  # GET /checklist_answers
  def index
    @checklist_answers = ChecklistAnswer.all
  end

  # GET /checklist_answers/1
  def show
  end

  # GET /checklist_answers/new
  def new
    @checklist_answer = ChecklistAnswer.new
  end

  # GET /checklist_answers/1/edit
  def edit
  end

  # POST /checklist_answers
  def create
    @checklist_answer = ChecklistAnswer.new(checklist_answer_params)

    if @checklist_answer.save
      redirect_to @checklist_answer, notice: 'Checklist answer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /checklist_answers/1
  def update
    if @checklist_answer.update(checklist_answer_params)
      redirect_to @checklist_answer, notice: 'Checklist answer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /checklist_answers/1
  def destroy
    @checklist_answer.destroy
    redirect_to checklist_answers_url, notice: 'Checklist answer was successfully destroyed.'
  end

  def toggle
    checklist = Checklist.find_by(title: params[:title])

    checklist ||= ChecklistAnswer.find_by(title: params[:title])
    if params[:is_checked] == 'true' && checklist.present?      
      current_user.checklist_answers.create(title: checklist.title, checklist_id: checklist.id, category: checklist.category)
    elsif params[:is_checked] == 'true' && checklist.blank? 

      current_user.checklist_answers.create(title: params[:title], category: params[:category] == 'for_labor' ? 'For Labor' : 'For the birth partner')
    elsif params[:is_checked] == 'false' && checklist.present? 
      x = current_user.checklist_answers.find_by(title: checklist.title)
      x.destroy if x.present?
    end
  end

  def restrictions
    question = Question.find(params[:ques_id])
    @hide_question = []
    @show_question = []
    @hide_option = []
    @show_option = []
    @restrict_questions = question.restrict_questions
    if @restrict_questions.present?
      @restrict_questions.each do |restrict_question|
        if params[:type] == 'checkbox'
          if restrict_question.ques_status == false && restrict_question.main_option_id == params[:opt_id].to_i && params[:checked] == 'true'
            @hide_question << restrict_question.base_ques_id      
          elsif restrict_question.ques_status == false && restrict_question.main_option_id == params[:opt_id].to_i && params[:checked] == 'false'
            @show_question << restrict_question.base_ques_id
          end 
          if restrict_question.option_status == false && restrict_question.main_option_id == params[:opt_id].to_i && params[:checked] == 'true'
            @hide_option << restrict_question.base_option_id
          elsif restrict_question.option_status == false && restrict_question.main_option_id == params[:opt_id].to_i && params[:checked] == 'false'
            @show_option << restrict_question.base_option_id
          end  
        elsif params[:type] == 'radio'
          if restrict_question.ques_status == false && restrict_question.main_option_id == params[:opt_id].to_i && params[:checked] == 'true'
            @hide_question << restrict_question.base_ques_id
          elsif restrict_question.ques_status == false && restrict_question.main_option_id != params[:opt_id].to_i
            @show_question << restrict_question.base_ques_id
          end    
          if restrict_question.option_status == false && restrict_question.main_option_id == params[:opt_id].to_i
            @hide_option << restrict_question.base_option_id
          elsif restrict_question.option_status == false && restrict_question.main_option_id != params[:opt_id].to_i
            @show_option << restrict_question.base_option_id
          end  
        end
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist_answer
      @checklist_answer = ChecklistAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def checklist_answer_params
      params.require(:checklist_answer).permit(:title, :user_id, :checklist_id, :category)
    end
end
