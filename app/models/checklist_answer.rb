class ChecklistAnswer < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title
	validates :title, :uniqueness => {:scope => :user_id}
end
