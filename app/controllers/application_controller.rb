class ApplicationController < ActionController::API
  before_filter :set_current_user
  attr_accessor :current_user

  private

  def set_current_user
    user = OauthToken.authenticate(bearer_token).try(:user)

    if user
      @current_user = user
    else
      head :unauthorized
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header = request.authorization
    header.remove(pattern) if header && header.match(pattern)
  end
end
