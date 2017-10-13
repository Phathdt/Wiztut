class AddAvatarToProfiles < ActiveRecord::Migration[5.1]
  def up
    add_attachment :profiles, :avatar
  end

  def down
    remove_attachment :profiles, :avatar
  end
end
