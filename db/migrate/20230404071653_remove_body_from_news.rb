class RemoveBodyFromNews < ActiveRecord::Migration[7.0]
  def change
    remove_column :news, :body, :text
  end
end
