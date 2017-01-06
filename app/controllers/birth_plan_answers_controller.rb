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
  	
  	params[:plan].each do |id, attribute| 
  		
      question_id = id.to_i
      @question = Question.find(question_id)
      @ques_type = @question.ques_type
      if @ques_type == 3
        attribute.each  do |option, value|  
          answer = BirthPlanAnswer.new
          answer.question_id = @question.id
          answer.question = @question.title
          answer.user_id = current_user.id
          answer.ques_type = @ques_type
          answer.answer =  value
          answer.birth_plan_id = @birth_plan.id
          answer.save
        end   
      else 
        answer = BirthPlanAnswer.create!(question: @question.title,
                                          user_id: current_user.id,
        	                                ques_type: @ques_type,
        	                                answer: attribute,
        	                                birth_plan_id: @birth_plan.id, 
        	                                question_id: @question.id)
      end      
    end
    redirect_to birth_plan_answer_path(@birth_plan), :notice => "Your response has been successfully submitted"
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
    @birth_plan = BirthPlan.first
    @user = current_user
    @answers = BirthPlanAnswer.where("user_id = ?", @user.id)
    #attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png')) 
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
              locals: {:answer => @answer, :question => @questions, user: @user}
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

  private

  def answer_params
  	params(:birth_plan_answer).permit(:id, :user_id, :answer, :question, :ques_type, :birth_plan_id)
  end 	
end
