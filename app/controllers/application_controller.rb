class ApplicationController < ActionController::API
  before_action :set_user, except: :users_controller

  private
    def set_user
      @user = User.where(auth_token: params[:auth_token]).first rescue unauthorized
    end

    def unauthorized
      render json: { message: "Not Authorized" }, status: :unauthorized
    end

    def users_controller
      return true if ( params[:controller] == "users" and ( ["sign_in","sign_up"].include?(params[:action]) ) )
    end
end
