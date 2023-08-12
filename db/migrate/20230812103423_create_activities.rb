class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :subtitle
      t.string :page_title
      t.string :icon

      t.timestamps
    end
  end
end
