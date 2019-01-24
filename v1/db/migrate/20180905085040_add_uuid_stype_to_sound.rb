class AddUuidStypeToSound < ActiveRecord::Migration[5.2]
  def change
    add_column :sounds, :uuid, :string
    add_column :sounds, :s_type, :integer
    add_column :sounds, :url, :string
    remove_column :sounds, :s_name, :string
  end
end
