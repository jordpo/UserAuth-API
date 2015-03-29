# == Schema Information
#
# Table name: oauth_tokens
#
#  id            :integer          not null, primary key
#  access_token  :string
#  refresh_token :string
#  user_id       :integer
#  refreshed     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OauthToken < ActiveRecord::Base
  REFRESH_TOKEN_EXPIRATION = 30.days

  belongs_to :user

  validates_presence_of :access_token, :refresh_token
  before_validation :set_access_token, :set_refresh_token

  scope :unexpired_refresh_token, -> {
    where('created_at >= ?', Time.now - REFRESH_TOKEN_EXPIRATION)
  }

  scope :expired_refresh_token, -> {
    where('created_at < ?', Time.now - REFRESH_TOKEN_EXPIRATION)
  }

  def self.authenticate(access_token)
    return nil if access_token.nil?

    token = find_by(access_token: access_token)
    token.unexpired? ? token : nil
  end

  def expires_in
    1.hour
  end

  def token_type
    'bearer'
  end

  def unexpired?
    Time.now < created_at + expires_in
  end

  def refresh!
    return false if refreshed?

    update_attributes(refreshed: true)
  end

  private

  def set_access_token
    self.access_token = generate_token(:access_token)
  end

  def set_refresh_token
    self.refresh_token = generate_token(:refresh_token)
  end

  def generate_token(type)
    begin
      token = SecureRandom.hex(32)
    end while self.class.exists?(type => token)

    token
  end
end
