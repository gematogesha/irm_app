class AddLinkToHeader < ActiveRecord::Migration[7.0]
  def change
    add_column :headers, :link, :string
  end
end
