# == Schema Information
#
# Table name: session_tokens
#
#  id            :bigint           not null, primary key
#  session_token :string           not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SessionToken < ApplicationRecord
  validates :user_id, presence: true
  validates :session_token, presence: true, uniqueness: true

  belongs_to :user
  
  # def self.generate_session_token
  #   SecureRandom::urlsafe_base64(16)
  # end

end
