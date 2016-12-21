class Option < ActiveRecord::Base
  #attr_accessor :option_title

  belongs_to :question
end
