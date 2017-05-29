class BirthPlanQuestion < ActiveRecord::Base
	#attr_accessor :birth_plan_id, :question_id

	belongs_to :birth_plan
	belongs_to :question
end
