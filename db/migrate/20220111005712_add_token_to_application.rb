class AddTokenToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :token, :string, :limit => 60
  end
end
