class User < ApplicationRecord
  validates :email, :password_digest, :session_token, :verification_token, presence: true
  validates :email, :session_token, :verification_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  after_initialize :set_verification_token

  has_many :notes

  attr_reader :password

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64(16)

    while self.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end

    token
  end

  def self.generate_verification_token
    token = SecureRandom.urlsafe_base64(16)

    while self.exists?(verification_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end

    token
  end

  def set_verification_token
    self.verification_token = self.class.generate_verification_token
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?

    user.password?(password) ? user : nil
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def verify!
    self.update_attribute(:activated, true)
  end

  def make_admin!
    self.update_attribute(:admin, true)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
