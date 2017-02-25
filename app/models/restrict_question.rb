class RestrictQuestion < ActiveRecord::Base
	belongs_to :questions, :class_name => "Question",
    :foreign_key => 'main_ques_id'

    belongs_to :option, :class_name => "Option",
    :foreign_key => 'main_option_id'
end
