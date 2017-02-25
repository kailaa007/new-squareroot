class BirthPlanAnswer < ActiveRecord::Base
#	attr_accessor :user_id, :question, :answer, :ques_type
 
  belongs_to :birth_plan	
  belongs_to :user
  has_many :answer_options, dependent: :destroy

  validates_presence_of :question

  accepts_nested_attributes_for :answer_options
end
