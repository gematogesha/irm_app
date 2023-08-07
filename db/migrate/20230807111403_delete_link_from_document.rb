class DeleteLinkFromDocument < ActiveRecord::Migration[7.0]
  def change
    remove_column :documents, :link
  end
end
