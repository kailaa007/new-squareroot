class BirthPlanAnswersController < ApplicationController
  layout 'devise'
  before_filter :authenticate_user!
  
  def get_restriction
    @restriction = []
    @restriction << RestrictQuestion.where(base_ques_id: params[:ques])
    @restriction << RestrictQuestion.where(main_ques_id: params[:ques])
    @restriction1 = @restriction.to_json.html_safe
    respond_to do | format |  
      format.js {render :layout => false, json: @restriction1}  
    end
  end  

  def new
    @birth_plan_record = BirthPlanAnswer.find_by_user_id(current_user.id)
    if @birth_plan_record.present?
      redirect_to birth_plan_answer_path
    else
      @birth_plan_answer = BirthPlanAnswer.find_by_user_id(current_user.id)
      @birth_plan = BirthPlan.first
    end  
  end  
	
  def create
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

  def show
    @birth_plan = BirthPlan.first
    @user = current_user
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

  def report
    @user       = current_user
    @birth_plan_answers    = current_user.birth_plan_answers
    if params[:print] == 'true'
      respond_to do |format|
        format.html do 
          render  layout: false
        end
      end
    else
      respond_to do |format|
        format.html do 
          render  layout: 'pdf'
        end
        format.pdf do
          render pdf: "report",
                template: "birth_plan_answers/report.html.erb",
                layout: 'pdf', 
                default_header:                 true,
                header: {
                  html:{        
                      template: 'shared/pdf_header',          # use :template OR :url
                      layout:   'pdf',             # optional, use 'pdf_plain' for a pdf_plain.html.pdf.erb file, defaults to main layout
                  }
                },
                footer: {
                  html: {
                    template: 'shared/pdf_footer',          # use :template OR :url
                      layout:   'pdf',  
                  }
                },
                locals: {:birth_plan_answers => @birth_plan_answers, user: @user}
        end
      end
    end
  end   

  def edit
    @answer = BirthPlanAnswer.where("user_id = ?", current_user.id)
    @birth_plan= BirthPlan.first
   # @birth_plan = BirthPlan.first
    #@user = current_user
    #@answers = BirthPlanAnswer.where("user_id = ?", @user.id)
  end  

  def update

  end  

  def save_session
    @birth_plan = BirthPlan.first
    @opt_blanks = []
    begin
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
  rescue
    puts 'rescued'
  end
    @required_questions = Question.where(:required => true)
    @cat_id = params[:c_id].to_i
    if @cat_id == 6
      current_user.update(:birth_plan_status => true) 
    end
  end

  private

  def answer_params
  	params(:birth_plan_answer).permit(:id, :user_id, :answer, :question, :ques_type, :birth_plan_id, answer_options_attributes: [:option_id, :birth_plan_answer_id])
  end 	
end
