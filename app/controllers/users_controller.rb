class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def sign_up
    user = User.new(user_params)
    if user.save
      render json: {user: user, message: "Signed Up Successfully"}
    else
      render json: {user: user, message: "Error while creating User"}
    end
  end

  def sign_in
    user = User.where(email: params[:email]).first
    if user.blank? or not user.valid_password?(params[:password])
      render json: { message: "Invalid USername or password" }, status: :unauthorized
    else
      render json: { user: user } 
    end
  end

  def gen_keys
    unless @user.key_pair.blank?
      if @user.generate_keys
        send_data(@user.key_pair, filename: "#{@user.name}_key_file}")
      else
        render json: { errors: @user, message: "Failure in Generating new key pair" }
      end
    else
      render json: { public_key: @user.public_key }
    end
  end


  protected
    def user_params
      params.require(:user).permit(:email, :name, :adhaar_no, :user_type)
    end

end
