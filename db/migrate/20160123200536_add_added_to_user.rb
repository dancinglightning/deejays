class AddAddedToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :added, :string
    add_column :users, :city,  :string
    add_column :users, :country,  :string
    add_column :users, :hear,  :string
    add_column :users, :info,  :string
    add_column :users, :group,  :string
    add_column :users, :link,  :string
    add_column :users, :admin,  :int

    add_column :songs, :user_id , :int
    add_column :songs, :user_name , :string

  end
end
