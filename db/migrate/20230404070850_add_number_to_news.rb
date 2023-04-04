class AddNumberToNews < ActiveRecord::Migration[7.0]
  def change
    add_column :news, :number, :string
  end
end
