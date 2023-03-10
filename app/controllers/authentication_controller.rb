class AuthenticationController < ApplicationController

    skip_before_action :authenticate_user

    def login 
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = JwtToken.encode(user_id: @user_id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                           username: @user.user_name }, status: :ok
        else
            render json: { errors: 'Unauthorized' }, status: :unauthorized
        end 
    end 
end
