class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.float :x
      t.float :y
      t.float :z

      t.timestamps
    end
  end
end
