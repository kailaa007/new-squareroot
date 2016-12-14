class Tag < ActiveRecord::Base

  # Gems
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :news, dependent: :nullify

end
