class UsersModule::CameraMan < UsersModule::ApplicationRecord
  # self.table_name = 'camera_man'
  has_secure_password
  validates_presence_of :email
end
