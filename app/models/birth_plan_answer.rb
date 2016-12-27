class BirthPlanAnswer < ActiveRecord::Base
#	attr_accessor :user_id, :question, :answer, :ques_type
 
  belongs_to :birth_plan	
  belongs_to :user

  validates_presence_of :question, :answer
end
