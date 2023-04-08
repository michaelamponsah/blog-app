class RenameColumnBioInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :Bio, :bio
  end
end
