class AddUniquenessToUsername < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'citext'
    change_column :users, :username, :citext
    add_index :users, :username, unique: true
  end
end
