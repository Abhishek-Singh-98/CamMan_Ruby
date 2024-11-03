class LoginsModule::LoginsController < LoginsModule::ApplicationController

  def login_user
    case params[:user_role]
    when 'camman'
      @camera_man = UsersModule::CameraMan.find_by(email: params[:camera_man][:email].downcase)
      if @camera_man&.authenticate(params[:camera_man][:password])
        @token = JwtAuthentication.encode(id: @camera_man.id)
        render json: {email: @camera_man.email, token: @token}
      else
        render json: {error: 'Invalid Password or Email'}
      end
    when 'client'
      @client = UsersModule::Client.find_by(email: params[:client][:email].downcase)
      if @client&.authenticate(params[:client][:password])
        @token = JwtAuthentication.encode(id: @client.id)
        render json: {email: @client.email, token: @token}
      else
        render json: {error: 'Invalid Password or Email'}
      end
    end
  end
end