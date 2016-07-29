class AddContactNumberAndFirstNameLastNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :contact_number_prefix, :string
    add_column :users, :contact_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
  end
end
