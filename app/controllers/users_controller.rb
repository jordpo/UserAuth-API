class UsersController < ApplicationController
  skip_before_filter :set_current_user

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
