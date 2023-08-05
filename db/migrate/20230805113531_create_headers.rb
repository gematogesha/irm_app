class CreateHeaders < ActiveRecord::Migration[7.0]
  def change
    create_table :headers do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
