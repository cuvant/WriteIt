class Micropost < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # Socialization Gem
  acts_as_mentioner
  
  # Acts as Votable gem
  acts_as_votable
  
  # searchkick
  attr_accessor :full_street_address
  
  scope :ordered, -> { order(created_at: :desc) }
  scope :of_followed_users, -> (following_users) { where(user_id: following_users).order(created_at: :desc) }
  scope :displayed, -> (page) { includes(:user, comments: :user).paginate(page: page.to_i, per_page: 3).ordered }
  
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :city, presence: true
  validates :street, presence: true
  validate  :picture_size
  
  geocoded_by :full_street_address
  after_validation :geocode, if: :street_address_changed?
  
  reverse_geocoded_by :latitude, :longitude, address: :full_street_address 
  before_validation :reverse_geocode, if: :street_address_empty?
  
  after_create_commit {NewMicropostBrodcastJob.perform_now(self, "first")}
  
  def full_street_address
    [street, number, city].compact.join(', ')
  end
  
  def full_street_address=(val)
    array_address = val.split(", ")
    if array_address.present?
      self.street = array_address[0]
      self.city = array_address[1]
      self.number = (self.street.match(/\s\d+$/)[0]).to_i if self.street.match(/\s\d+$/).present?
      if self.number.present?
        self.street = self.street.gsub(self.number.to_s, "")
      end
    end
  end
  
  def street_address_empty?
    return self.street.blank?
  end
  
  def street_address_changed?
    street_changed? || number_changed? || city_changed?
  end
  
  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
