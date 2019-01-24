class CreateSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :sounds do |t|
      t.string :uuid
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
