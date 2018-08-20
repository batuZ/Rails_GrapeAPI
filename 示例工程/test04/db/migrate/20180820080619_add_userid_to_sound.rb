class AddUseridToSound < ActiveRecord::Migration[5.2]
  def change
    add_reference :sounds, :user, foreign_key: true
  end
end
