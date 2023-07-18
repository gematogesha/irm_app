class CreateLeaders < ActiveRecord::Migration[7.0]
  def change
    create_table :leaders do |t|
      t.string :name
      t.text :post
      t.string :page_title

      t.timestamps
    end
  end
end
