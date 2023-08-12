class RenameSlidersToBanners < ActiveRecord::Migration[7.0]
  def change
    rename_table :sliders, :banners
  end
end
