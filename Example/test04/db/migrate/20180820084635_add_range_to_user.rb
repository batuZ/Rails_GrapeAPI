class AddRangeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :range, :float, default:20.0
  end
end
