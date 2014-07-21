class User < ActiveRecord::Base 
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :user_cards, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, :presence => true, length: { maximum: 100 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false}

  validates :password, length: { minimum: 6 }

  has_secure_password

  def should_generate_new_friendly_id?
    new_record?
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  private
  def create_remember_token
    self.remember_token = User.digest( User.new_remember_token )
  end

end