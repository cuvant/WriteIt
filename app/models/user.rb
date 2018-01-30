class User < ApplicationRecord
  # Followers -> who follows the user
  # Following -> who the user is following
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 40 }
  validates :email, presence: true
  
  # Socialization Gem
  acts_as_mentionable
  
  # Acts as Voter gem
  acts_as_voter
  
  include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :instagram]

  before_save :ensure_authentication_token

  mount_uploader :image, ImageUploader
  mount_uploader :timeline_cover, TimelineCoverUploader

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
      user = User.load_user_from_omniauth(user, auth)
    end
  end

  def feed
    Micropost.where("user_id = ?", id)
  end
  
  def follow(user_id)
    if follow = following_relationships.create(following_id: user_id)
      Notification.create(user_id: user_id, notified_by_id: self.id, notice_type: 'follow', follow_id: follow.id )
      return true
    else
      return false
    end
  end
  
  def unfollow(user_id)
    if follow = following_relationships.find_by(following_id: user_id)
      follow.destroy!
      Notification.where(user_id: user_id, notified_by_id: self.id, notice_type: 'follow', follow_id: follow.id).destroy_all
      return true
    else
      return false
    end
  end
  
  # Function tries to like a micropost
  # If successfully liked a micropost a notification is created as well
  def try_like(micropost)
    if self.likes(micropost)
      
      like = micropost.get_upvotes.where(voter_id: self.id).pluck(:id).first
      Notification.create(user_id: micropost.user_id, notified_by_id: self.id, micropost_id: micropost.id, like_id: like, notice_type: "like")
      MicropostBrodcastJob.perform_later(micropost, "like", "true", self.id)
      return true
    else
      return false
    end
  end
  
  # Function that tries to unlike a micropost
  # If unlike'd successfully, we destroy the created notification (notification was created when user liked) as well
  def try_unlike(micropost)
    like_id = micropost.get_upvotes.where(voter_id: self.id).pluck(:id).first
    if self.dislikes(micropost)
      Notification.where(like_id: like_id).destroy_all
      MicropostBrodcastJob.perform_later(micropost, "like", "false", self.id)
      return true
    else
      return false
    end
  end
  
  # Returns an array of arrays with 2 elements, first element - notificaton type, second element - created_at
  # ex [ ['like', 'date'], [comment, 'date'], ..]
  def activities
    return Notification.activities(self.id)
  end
  
  # Returns all the user_names that SELF (user) is following
  def following_user_names
    return following.pluck(:user_name)
  end
  
  def following_user_ids
    self.following_relationships.pluck(:following_id)
  end
  
  def followers_user_ids
    self.follower_relationships.pluck(:follower_id)
  end
  
  # Returns 5 users that a user is not following
  def follow_recomandations
    return User.where.not(id: following_user_ids << self.id).limit(5).order('RANDOM()')
  end
  
  # Returns SELF's (user) microposts paginated and eager loaded
  def displayed_microposts(page)
    microposts.displayed(page)
  end
  
  def online_followings
    online_followings_ids = following_user_ids & $redis_onlines.keys.map(&:to_i)
    return User.where(id: online_followings_ids).to_a
  end
  
  def is_online?
    return true if $redis_onlines.keys.include?("#{self.id}")
  end

  private

    def self.load_user_from_omniauth(user, auth)
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email if user.email.blank?
      user.email = auth.info.nickname + "@#{auth.provider}.com" if user.email.blank?
      user.password = Devise.friendly_token[0,20] if user.password.blank?
      user.remote_image_url = auth.info.image.gsub('http://','https://') if user.remote_image_url.blank?

      name = auth.info.name.split(" ")
      user.first_name = name[0] if user.first_name.blank?
      user.last_name = name[1] if user.last_name.blank?
      user.user_name = name.join("_") if user.user_name.blank?
      
      return user
    end

end
