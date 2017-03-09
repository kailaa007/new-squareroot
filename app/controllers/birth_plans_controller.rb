class BirthPlansController < ApplicationController
  layout "devise"
  before_action :authenticate_user!, except: [:index]
  def index
    if current_user.present?
      redirect_to profile_path
    end
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

  def set_birth_plan
    save_session
    @checklists         = Checklist.order(:category, :sub_category)
    @category           = @checklists.map(&:category).uniq.compact
    @checklist_answers  = current_user.checklist_answers
    @self_checklists    = current_user.checklist_answers.where(checklist_id: [nil, ''])
    @cat_id             = params[:c_id].present? ? params[:c_id].to_i : 1
    @birth_plan_checklist  = BirthPlan.first.try(:checklist_on) == Question::CATEGORY_TYPES[@cat_id-1]
    @questions          = Question.where(category: Question::CATEGORY_TYPES[@cat_id-1]).includes(:restrict_questions).order(:order)
    @restricted_questions  = Question.where(id: current_user.birth_plan_answers.includes(:answer_options).map(&:question_id)).map(&:restrict_questions).flatten.compact.select{|x| x.ques_status == false}.map(&:base_ques_id)
    @restricted_options  = RestrictQuestion.where( main_option_id: current_user.birth_plan_answers.map(&:answer_options).flatten.map(&:option_id), option_status: false).map(&:base_option_id)
    @birth_plan         = BirthPlanAnswer.new
    session[:answers] = []
  end

  def save_session
    @birth_plan = BirthPlan.first
    @opt_blanks = []
    @@session = session[:answers]
    if @@session.present?
      @@session.each do |q_id, values|
        @question = Question.find(q_id)     
        values.each do |typ, content|
          case typ
          when 'radio'
            option_id = content["option_id"]
            x = current_user.birth_plan_answers.where(question_id: @question.id)
            x.destroy_all if x.present?
            if option_id.present?
              @option = Option.find(option_id)
              if @option.textbox_enable == true && content['text'].present?
                current_user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer_options_attributes: [option_id: option_id, textbox_answer: content["text"]]) if option_id.present?
                @opt_blanks.delete(@option.id)
              elsif @option.textbox_enable == false
                current_user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer_options_attributes: [option_id: option_id])
              elsif @option.textbox_enable == true && content['text'].blank?
                @opt_blanks << @option.id
              end
            end
          when 'checkbox'
            
              content = content.reject { |c| c.empty? }
              x = current_user.birth_plan_answers.where(question_id: @question.id)
              x.destroy_all if x.present?
              if content.present?
                bp = current_user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id)
                content.each do |checkb|
                  AnswerOption.create(option_id: checkb, birth_plan_answer_id: bp.id) if checkb.present?
                end
              end
          when 'textbox'
            
            x = current_user.birth_plan_answers.where(question_id: @question.id)
            x.destroy_all if x.present?
            if content.present?
              current_user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer: content.to_s )
            end
          end
        end
      end
      #current_user.birth_plan_answers.where(question_id: session[:restricted_question_id]).destroy_all
    end

    @required_questions = Question.where(:required => true)
    @cat_id = params[:c_id].to_i
    if @cat_id == 6
      current_user.update(:birth_plan_status => true) 
    end
  end

  def send_email_report    
    UserMailer.send_report(current_user).deliver
  end
 private

 def birth_plan_params
   params.require(:birth_plan).permit(:title, :status, :description, birth_plan_answer_attributes: [:id, :question, :answer, :ques_type, :user_id])
 end

end