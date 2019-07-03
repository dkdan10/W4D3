# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :cats
  has_many :cat_rental_requests
  has_many :session_tokens

  # after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user && user.is_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end

  def generate_session_token
    token = SecureRandom::urlsafe_base64(16)
    SessionToken.create!(user_id: self.id, session_token: token)
    token
  end

  # def reset_session_token!
  #   self.update!(session_token: User.generate_session_token)
  #   self.session_token
  # end

  # private

  # def ensure_session_token
  #   SessionToken.find_by(user_id: self.id)
  #   self.session_token ||= User.generate_session_token
  # end

 

end
