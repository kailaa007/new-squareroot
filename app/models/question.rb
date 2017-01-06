class Question < ActiveRecord::Base
	QUESTION_TYPES = {
    'True/False' => 1,
    'Single Select Question'=> 2,
    'Multiple Select Question' => 3,
    'Detail Answer' => 4,
    'Email Field' => 5,
    'Input Field' => 6,
  }
  before_save :capitalize_title
  before_create :set_order	
  self.per_page = 10
  validates_presence_of :title, :ques_type
  validates_uniqueness_of :order, allow_nil: true, allow_blank: true
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

  def capitalize_title
    self.title = self.title.capitalize
  end  

  def self.ordered
    order("questions.order")
  end  

  def set_order       
    if !Question.first.present?
      self.order = 1
    else
      self.order = Question.maximum('order') +1
    end  
  end  
end
