class Administrator < ActiveRecord::Base
  #attr_accessor :name, :email, :password, :password_confirmation, :reset_token, :resent_sent_at
  # Gems
  has_secure_password

  # Validations
  #validates :name, :email, presence: true, :allow_blank => true
  #validates :email, email: true, :allow_blank => true
  validates_uniqueness_of :name
  validates :password, confirmation: true

  before_create { generate_token(:auth_token) }

  

	def send_password_reset
	  generate_token(:reset_token)
	  self[:resent_sent_at] = Time.now
	  save!
	  AdminMailer.password_reset(self).deliver_now
	end



  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Administrator.exists?(column => self[column])
  end

end
