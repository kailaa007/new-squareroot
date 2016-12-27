class News < ActiveRecord::Base
  
  self.per_page = 10

  # Gems
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  belongs_to :tag

  # Validations
  validates :title, :excerpt, :link, :post_date, :author, presence: true

end
