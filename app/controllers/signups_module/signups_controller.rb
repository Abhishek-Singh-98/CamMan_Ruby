class SignupsModule::SignupsController < SignupsModule::ApplicationController
  before_action :authorize_user, only: [:signup_user]
  
  def signup_page
    render '/signups_module/signup_page', format: :html
  end

  def signup_user
      if @user.present?
       return render json: {error: 'Email already registered'}
      end
      # hashed_params = params.deserialize
      signup_params[:email] = signup_params[:email].downcase
      @user = params[:user_role] == 'camman' ? UsersModule::CameraMan.new(signup_params) : UsersModule::Client.new(signup_params)

      if @user.save
        @token = JwtAuthentication.encode(id: @user.id)
        render json: {success: true,
                      data: {email: @user.email, user_role: params[:user_role],
                      token: @token}}, status: 200
      else
          render json: {errors: @user.errors.messages}, status: :unprocessable_entity
      end
  end

  private

  def signup_params
    params.permit(:email, :password_digest, :password, :password_confirmation, :password_digest)
  end

  def authorize_user
    case params[:user_role] 
    when 'camman'
      @user = UsersModule::CameraMan.find_by(email: params[:email]&.downcase)
    when 'client'
      @user = UsersModule::Client.find_by(email: params[:email]&.downcase)
    end
  end
end