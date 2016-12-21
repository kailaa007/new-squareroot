class BirthPlan < ActiveRecord::Base

  has_many :birth_plan_questions, dependent: :destroy
  has_many :questions, through: :birth_plan_questions
  	
end
