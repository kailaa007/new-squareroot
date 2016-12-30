class BirthPlan < ActiveRecord::Base

  has_many :birth_plan_questions, dependent: :destroy
  has_many :questions, through: :birth_plan_questions
  has_many :birth_plan_answers
  
  accepts_nested_attributes_for :birth_plan_answers, allow_destroy: true
  accepts_nested_attributes_for :birth_plan_questions, allow_destroy: true
  #has_one :user

  def self.active
    where(status: true)
  end
  	
end
