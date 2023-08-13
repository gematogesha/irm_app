class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :page_title
      t.string :icon

      t.timestamps
    end
  end
end
