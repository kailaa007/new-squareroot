class AnswerOption < ActiveRecord::Base
	belongs_to :birth_plan_answer
	belongs_to :option
	validates_presence_of :option_id
end