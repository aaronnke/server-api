class UsersController < ApplicationController
  include Response
  require './lib/JsonWebToken'

  def create
    @user = User.new(user_params)

    if @user.save
      json_response(@user, :created)
    else
      json_response(@user.errors.full_messages, :bad_request)
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.authenticate(params[:password])
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
