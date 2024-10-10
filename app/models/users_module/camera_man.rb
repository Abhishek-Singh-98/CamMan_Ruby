class UsersModule::CameraMan < UsersModule::ApplicationRecord
  # self.table_name = 'camera_man'
  validates_presence_of :email, :phone_number, :company_name, :name
end
