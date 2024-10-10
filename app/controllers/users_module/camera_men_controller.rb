module UsersModule
  class CameraMenController < ApplicationController
    
    def new
      @camera_man = CameraMan.new 
    end

    def create
      @camera_man = CameraMan.new(cam_params)
      if @camera_man.save
        redirect_to @camera_man
      else
        render "users_module/camera_men/new"
      end
    end

    def show
      @camera_man = CameraMan.find_by_id(params[:id])
      if @camera_man.present?
        render "users_module/camera_men/show"
      else
        render "users_module/camera_men/show"
      end
    end
    
    private
    def cam_params
      params.require(:camera_man).permit(:name, :company_name, :email, :phone_number)
    end
  end
end