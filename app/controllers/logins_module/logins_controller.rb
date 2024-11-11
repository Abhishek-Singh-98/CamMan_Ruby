class LoginsModule::LoginsController < LoginsModule::ApplicationController
  before_action :find_user

  def login_user
    if @user&.authenticate(params[:camera_man][:password])
      @token = JwtAuthentication.encode(id: @user.id)
      render json: {email: @user.email, token: @token}
    else
      render json: {error: 'Invalid Password or Email'}
    end
  end

  private

  def find_user
    return render json: {error: "user_role missing"} if params[:user_role].empty?

    case params[:user_role]
    when 'camman'
      @user = UsersModule::CameraMan.find_by(email: params[:camera_man][:email].downcase)
    when 'client'
      @user = UsersModule::Client.find_by(email: params[:client][:email].downcase)
    end
  end
end