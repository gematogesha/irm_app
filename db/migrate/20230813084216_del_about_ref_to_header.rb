class DelAboutRefToHeader < ActiveRecord::Migration[7.0]
  def change
    remove_reference :headers, :about, index: true, foreign_key: true
  end
end
