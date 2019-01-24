class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :userName
      t.string :password_digest
      t.string :userBio

      t.timestamps
      t.index :userName, unique: true
    end
  end
end
