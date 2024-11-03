class SignupsModule::SignupsController < SignupsModule::ApplicationController
  
  def signup_user
    case params[:user_role] 
    when 'camman'
      @camera_man = UsersModule::CameraMan.find_by(email: params[:camera_man][:email]&.downcase)
      if @camera_man.present?
       return render json: {error: 'Email already registered'}
      end
      # hashed_params = params.deserialize
      camman_params[:email] = camman_params[:email].downcase
      @camera_man = UsersModule::CameraMan.new(camman_params)
      if @camera_man.save
        @token = JwtAuthentication.encode(id: @camera_man.id)
        render json: {success: true,
                      data: {email: @camera_man.email, user_role: params[:user_role],
                      token: @token}}, status: 200
      else
          render json: {errors: @camera_man.errors.messages}, status: :unprocessable_entity
      end
    when 'client'
      @client = UsersModule::Client.find_by(email: client_params[:email]&.downcase)
      if @client.present?
       return render json: {error: 'Email already registered'}
      end

      client_params[:email] = client_params[:email].downcase
      @client = UsersModule::Client.new(client_params)
      if @client.save
        @token = JwtAuthentication.encode(id: @client.id)
        render json: {success: true,
                      data: {email: @client.email, user_role: params[:user_role],
                      token: @token}}, status: 200
      else
          render json: {errors: @client.errors.messages}, status: :unprocessable_entity
      end
    end
  end

  private

  def camman_params
    params.require(:camera_man).permit(:name, :company_name, :email, :phone_number,
                                              :password_digest, :password, :password_confirmation)
  end

  def client_params
    params.require(:client).permit(:name, :email, :password, :phone_number,
                                              :password_confirmation, :password_digest)
  end
end