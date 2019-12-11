class ChangeAdded < ActiveRecord::Migration[4.2]
  def change
    change_column :songs, :added, :string
  end
end
