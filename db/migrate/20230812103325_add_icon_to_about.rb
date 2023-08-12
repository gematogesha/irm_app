class AddIconToAbout < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :icon, :string
  end
end
