class LoginsModule::ApplicationController < ApplicationController
  include JwtAuthentication

  def authenticate
    header = request.header['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JwtAuthentication.decode(header)
      @current_user = CameraMan.find_by_id(@decoded[:id])
    rescue ActiveRecord::ActiveRecordError => e
      render json: {errors: e.messages}, status: :not_found
    rescue JWT::Base64DecodeError => e
      render json: {errors: e.messages}, status: :unauthorized
    end
  end
end