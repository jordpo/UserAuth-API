class UsersController < ApplicationController
  def create
    render json: {}, status: :created
  end
end
