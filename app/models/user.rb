class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :checklist_answers
  has_many :birth_plan_answers
  #validates_presence_of :email, :password
  validates :terms_n_condition, presence: true
  self.per_page = 10

end
