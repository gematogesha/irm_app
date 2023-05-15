class CreateSliders < ActiveRecord::Migration[7.0]
  def change
    create_table :sliders do |t|
      t.string :title
      t.text :description
      t.string :link      

      t.timestamps
    end
  end
end
