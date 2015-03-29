class OauthController < ApplicationController
  skip_before_filter :set_current_user

  def status
    render json: {}, status: :ok
  end

  def create
    user = User.find_by(email: params[:username])

    if user && user.authenticate(params[:password])
      token = OauthToken.create(user: user)

      render json: token
    else
      head :unauthorized
    end
  end

  def refresh
    token = OauthToken.unexpired_refresh_token.find_by(refresh_token: params[:refresh_token])

    if token && token.refresh!
      render json: OauthToken.create(user: token.user)
    else
      head :unauthorized
    end
  end
end
