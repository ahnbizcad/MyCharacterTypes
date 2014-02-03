class AddPassswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, 			 :string
    add_column :users, :password, 						 :string

    # The password_confirmation attribute is added automatically with the method has_secure_password in the user model
    #add_column :users, :password_confirmation, :string
  end
end
