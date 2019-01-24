class AddSoundidToPosition < ActiveRecord::Migration[5.2]
  def change
    add_reference :positions, :sound, foreign_key: true
  end
end
