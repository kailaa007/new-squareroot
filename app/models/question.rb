class Question < ActiveRecord::Base
	QUESTION_TYPES = {
    'True/False' => 1,
    'Single Select Question'=> 2,
    'Multiple Select Question' => 3,
    'Detail Answer' => 4,
    'Email Field' => 5,
    'Input Field' => 6,
  }
  
  self.per_page = 10

  #gems
  extend FriendlyId
  friendly_id :title, use: :slugged

  #attr_accessor :title, :type, :note
  has_many :options, dependent: :destroy

  has_many :birth_plan_questions, dependent: :destroy
  has_many :birth_plans, through: :birth_plan_questions

  accepts_nested_attributes_for :options, allow_destroy: true

  def selected_option
  	QUESTION_TYPES.invert
  end	
end
