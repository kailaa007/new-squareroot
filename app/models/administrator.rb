class Administrator < ActiveRecord::Base

  # Gems
  has_secure_password

  # Validations
  validates :name, :email, presence: true
  validates :email, email: true

end
