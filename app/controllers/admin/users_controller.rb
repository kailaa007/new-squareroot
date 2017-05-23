class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end 

  def destroy
    @user = User.find(params[:id])
    @user.destroy
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
  
  def save_session
    @birth_plan = BirthPlan.first
    @cat_id = params[:birth_plan_answer][:c_id].to_i
    if params[:answers].present?
      params[:answers].keys.each do |k|
        if session[:answers].blank?
          session[:answers] = params[:answers] 
        else 
          session[:answers][k] = params[:answers][k]
        end
      end
    end
    @@session = session[:answers]
    @restricted_main_option_ids = session[:answers].inject([]){|x,y| x << y.last['checkbox'] || y.last['radio'] }.flatten.compact
    session[:restricted_question_id] = RestrictQuestion.where(main_ques_id: @@session.keys, ques_status: false, main_option_id: @restricted_main_option_ids).pluck(:base_ques_id)
    session[:restricted_option_ids] = RestrictQuestion.where(main_ques_id: @@session.keys, option_status: false, main_option_id: @restricted_main_option_ids).pluck(:base_option_id)
    @restricted_questions   = session[:restricted_question_id]
    @restricted_options     = session[:restricted_option_ids]
    @unrestricted_questions  = Question.where.not(id: @restricted_questions).pluck(:id)


    
  end

  def save_questions
      @birth_plan = BirthPlan.first
    @user = User.find(params[:id])
    @opt_blanks = []
    begin
      @@session.each do |q_id, values|
        @question = Question.find(q_id)     
        values.each do |typ, content|
          case typ
          when 'radio'
            option_id = content["option_id"]
            x = @user.birth_plan_answers.where(question_id: @question.id)
            x.destroy_all if x.present?
            if option_id.present?
              @option = Option.find(option_id)
              if @option.textbox_enable == true && content['text'].present?
                @user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer_options_attributes: [option_id: option_id, textbox_answer: content["text"]]) if option_id.present?
                @opt_blanks.delete(@option.id)
              elsif @option.textbox_enable == false
                @user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer_options_attributes: [option_id: option_id])
              elsif @option.textbox_enable == true && content['text'].blank?
                @opt_blanks << @option.id
              end
            end
          when 'checkbox'
            
              content = content.reject { |c| c.empty? }
              x = @user.birth_plan_answers.where(question_id: @question.id)
              x.destroy_all if x.present?
              if content.present?
                bp = @user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id)
                content.each do |checkb|
                  AnswerOption.create(option_id: checkb, birth_plan_answer_id: bp.id) if checkb.present?
                end
              end
          when 'textbox'
            
            x = @user.birth_plan_answers.where(question_id: @question.id)
            x.destroy_all if x.present?
            if content.present?
              @user.birth_plan_answers.create(question_id: @question.id, question: @question.title, ques_type: @question.ques_type, birth_plan_id: @birth_plan.id, answer: content.to_s )
            end
          end
        end
      end
      #@user.birth_plan_answers.where(question_id: session[:restricted_question_id]).destroy_all
  rescue
    puts 'rescued'
  end
    @required_questions = Question.where(:required => true)
    @cat_id = params[:c_id].to_i
    if @cat_id == 6
      @user.update(:birth_plan_status => true) 
    end
  end
end