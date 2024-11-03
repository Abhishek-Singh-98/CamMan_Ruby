class SignupsModule::SignupsController < SignupsModule::ApplicationController
  
  def signup_user
    case params[:user_role] 
    when 'camman'
      @camera_man = UsersModule::CameraMan.find_by(email: params[:camera_man][:email]&.downcase)
      if @camera_man.present?
       return render json: {error: 'Email already registered'}
      end
      # hashed_params = params.deserialize
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
      
    end
  end

  private

  def camman_params
    params.require(:camera_man).permit(:name, :company_name, :email, :phone_number, :password_digest, :password, :password_confirmation)
  end

  def client_params
    params.require(:camera_man).permit(:name, :email, :password, :password_confirmation, :password_digest)
  end
end