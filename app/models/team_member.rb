class TeamMember < ActiveRecord::Base

  self.per_page = 10

  # Gems
  has_attached_file :photo,
    :styles => {
      :standard => {
        :geometry => '130x130#',
        :format   => 'jpg'
      },
      :retina => {
        :geometry => '260x260#',
        :format   => 'jpg'
      },
      :standard_bw => {
        :geometry => '130x130#',
        :format   => 'jpg',
        :convert_options => '-colorspace Gray'
      },
      :retina_bw => {
        :geometry => '260x260#',
        :format   => 'jpg',
        :convert_options => '-colorspace Gray'
      }
    }

  # Validations
  # validates :name, :title, :role, :photo, presence: true
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png image/gif)

  scope :advisors, -> { where('lower(role) = ?', 'advisor') }
  scope :team, -> { where('lower(role) != ?', 'advisor') }

  # Callbacks
  before_create :set_position

  # Methods
  def to_s
    name
  end

  def set_position
    self.position = self.class.count
  end

  def is_advisor?
    role.downcase == 'advisor'
  end

end
