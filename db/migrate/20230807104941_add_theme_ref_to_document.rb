class AddThemeRefToDocument < ActiveRecord::Migration[7.0]
  def change
    add_reference :documents, :theme, index: true, foreign_key: true
    add_reference :headers, :about, index: true, foreign_key: true
    remove_column :headers, :link
  end
end
