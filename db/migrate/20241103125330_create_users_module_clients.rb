class CreateUsersModuleClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.timestamps
    end
  end
end
