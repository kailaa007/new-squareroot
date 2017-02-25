class AnswerOption < ActiveRecord::Base
	belongs_to :birth_plan_answer
	validates_presence_of :option_id
end