class News < ActiveRecord::Base

  # Gems
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  belongs_to :tag

  # Validations
  validates :title, :excerpt, :link, :post_date, :author, presence: true

end
