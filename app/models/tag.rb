class Tag < ActiveRecord::Base

  self.per_page = 10

  # Gems
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_many :news, dependent: :nullify

end
