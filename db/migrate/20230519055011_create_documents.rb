class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :page_title

      t.timestamps
    end
  end
end
