class Option < ActiveRecord::Base
  #attr_accessor :option_title

  belongs_to :question
  has_many :answer_option
end
