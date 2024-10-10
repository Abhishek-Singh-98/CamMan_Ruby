class CreateUsersModuleCameraMen < ActiveRecord::Migration[7.0]
  def change
    create_table :camera_men do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :company_name
      t.timestamps
    end
  end
end
