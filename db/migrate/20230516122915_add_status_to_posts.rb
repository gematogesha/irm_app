class AddStatusToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :hot, :boolean, :default => false
    add_column :posts, :best, :boolean, :default => false
  end
end
