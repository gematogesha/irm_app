class AddSubtitleToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :subtitle, :text
  end
end
